From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 02/11] mmc: deprecate redundant cd-inverted and wp-inverted DT properties
Date: Wed, 30 Jan 2013 19:20:12 -0500
Message-ID: <874nhyryo3.fsf@octavius.laptop.org>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
	<201301301629.45511.arnd@arndb.de>
	<Pine.LNX.4.64.1301301743470.3113@axis700.grange>
	<201301310009.34426.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <201301310009.34426.arnd@arndb.de> (Arnd Bergmann's message of
	"Thu, 31 Jan 2013 00:09:34 +0000")
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jan 30 2013, Arnd Bergmann wrote:
>> > From the code, I understand that of_get_named_gpio() would return a gpio
>> > line with the polarity already inverted if it's specified that way,
>> 
>> Sorry, don't understand. of_get_named_gpio() just returns a GPIO number, 
>> not GPIO level. It doesn't even actually request the GPIO for the specific 
>> user. Or do you mean, that gpio_chip::of_xlate() should request the chip 
>> to invert the GPIO from now on?
>
> I'm not saying that it should, I just thought that it did that already,
> but I may be wrong with that. Where does the polarity of a gpio
> line normally get set?

of_get_named_gpio() intentionally discards the specified flags, but
of_get_named_gpio_flags(.., .., .., &gpio_flags) retrieves them, and
gpio_flags will == OF_GPIO_ACTIVE_LOW if that's how the gpio's been
specified in the DT.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
