using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UnitTestProject
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            // Arrange
            var number1 = 5;
            var number2 = 8;

            // Act
            var sum = number1 + number2;

            // Assert
            Assert.AreEqual(13, sum);
        }
    }
}
