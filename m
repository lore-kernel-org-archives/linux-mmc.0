From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 00/12] usb/mmc/power: Generic power sequence (and fix
 USB/LAN when TFTP booting)
Date: Tue, 07 Jun 2016 08:03:55 +0200
Message-ID: <575663CB.3070600@samsung.com>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <2034186.JKeBi87zYl@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <2034186.JKeBi87zYl@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: hzpeterchen@gmail.com, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.or, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 06/06/2016 10:43 PM, Heiko St=FCbner wrote:
> Hi,
>=20
> Am Mittwoch, 1. Juni 2016, 10:02:09 schrieb Krzysztof Kozlowski:
>> My third approach for a USB power sequence which fixes usb3503+lan
>> on Odroid U3 board if it was initialized by bootloader
>> (e.g. for TFTP boot).
>=20
> I was just tackling a similar bringup problem regarding an embedded u=
sb hub=20
> and usb-sata bridge and stumbled upon this series.
>=20
> While on my (rockchip-)boards it's always "just" a reset pin that nee=
ds=20
> handling, this series looks like it would solve exactly that problem =
in a very=20
> nice way.
>=20
> So while I cannot provide any meaningful insight right now, it would =
be cool=20
> if you could keep me in the loop, as I'm really looking forward to th=
is series=20
> progressing.
>=20

Sure, good to know that this problem affects more people. I do not feel
such alone anymore. ;)

Best regards,
Krzysztof
