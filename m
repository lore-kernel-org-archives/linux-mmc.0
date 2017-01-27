From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/4] mmc: bcm2835: Add new driver for the internal SD
 controller.
Date: Fri, 27 Jan 2017 17:04:33 +0100
Message-ID: <ec09cd58-6613-82d7-60a9-7a7c2d9ae673@i2se.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-3-git-send-email-kraxel@redhat.com>
 <CAPDyKFoWyZaRLhuBnFfJupxRnUvq-JWczS7ObjAGat056MCEyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFoWyZaRLhuBnFfJupxRnUvq-JWczS7ObjAGat056MCEyw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux@armlinux.org.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Am 27.01.2017 um 16:27 schrieb Ulf Hansson:
> On 27 January 2017 at 12:36, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> From: Eric Anholt <eric@anholt.net>
>>
>> The 2835 has two SD controllers:  The Arasan SDHCI controller (supported
>> by the iproc driver) and a custom SD controller.  This patch adds a
>> driver for the custom SD controller.
>>
>> The custom controller runs faster, and driving the sdcard with the
>> custom controller also allows to drive the rpi3 wifi with the iproc
>> driver.
>>
> I don't understand this relationship. Is this somewhat configurable in runtime?

The configuration is done by devicetree via pin muxing. AFAIK both SD
controller are available on the same pins (2 pin groups = pin 22 to 27 +
pin 48 to 53). So it's possible to use both SD controllers at the same
time with different pin groups. This is necessary to use Wifi via SDIO
on the RPi 3 while the other controller handles SD card with the rootfs.

>
> Is the WIFI module a removable SDIO card?

No

>  So you can decide which
> controller that is best suited to use?

Yes, but it requires also both drivers.

>
> Kind regards
> Uffe
