From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 02/12] ARM: ep93xx: vision_ep9307: Use MMC CD and RO GPIO
Date: Fri, 26 Jul 2013 11:26:03 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC5C212B@AUSP01VMBX24.collaborationhost.net>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1374794808-21890-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <ADE657CA350FB648AAC2C43247A983F0021DAC5C20AC@AUSP01VMBX24.collaborationhost.net>
 <1818634.2aPQusYJQq@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1818634.2aPQusYJQq@avalon>
Content-Language: en-US
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Friday, July 26, 2013 2:55 AM, Laurent Pinchart wrote:
> On Thursday 25 July 2013 19:19:52 H Hartley Sweeten wrote:
>> On Thursday, July 25, 2013 4:27 PM, Laurent Pinchart wrote:
>>> Pass the CD and RO GPIO numbers to the MMC SPI driver and remove the
>>> custom .get_cd() and .get_ro() callback functions.
>>> 
>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>
>>> ---
>>> 
>>>  arch/arm/mach-ep93xx/vision_ep9307.c | 56  +++---------------------------
>>>  1 file changed, 4 insertions(+), 52 deletions(-)

<snip>

>> I tested this and it _kind_ of works.
>> 
>> The card detect is a bit flaky due to the gpio interrupt debounce not being
>> enabled.
>> 
>> The only way I can see to fix this is add the following to this patch:

<snip>

> What about extending the mmc_spi and MMC core with GPIO debounce support ? The 
> mmc_spi driver would get a new cd_gpio_debounce field, which would be passed 
> to mmc_gpio_request_cd(). I can cook up a patch.

Works for me. That would also remove the need for the platform init to request then free
the GPIO just to set the debounce.

Make sure you do the gpiu_set_debounce() after the GPIO has been requested or you
trigger a WARN due to the auto-requested GPIO. Then, of course, the drivers gpio request
will fail...

I'll give it a test when you post it.

Thanks,
Hartley

