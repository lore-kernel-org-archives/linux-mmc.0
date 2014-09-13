From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 09/12] ARM: sunxi: dt: Add sample and output mmc clocks
Date: Sat, 13 Sep 2014 16:24:14 +0800
Message-ID: <CAGb2v66KeidqMvYCt53F3aqTUAxziSR6dU1cuUyNbsZyN0Av+A@mail.gmail.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-10-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v676B=pbKDnAfb3yUdL1ORgbacNTo=5EsTauNo+H993Agw@mail.gmail.com> <20140913081804.GY31276@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:57319 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbaIMIYf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 13 Sep 2014 04:24:35 -0400
In-Reply-To: <20140913081804.GY31276@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, Chris Ball <chris@printf.net>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, Sep 13, 2014 at 4:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Sep 12, 2014 at 06:23:02PM +0800, Chen-Yu Tsai wrote:
>> >                 mmc0: mmc@01c0f000 {
>> >                         compatible = "allwinner,sun4i-a10-mmc";
>> >                         reg = <0x01c0f000 0x1000>;
>> > -                       clocks = <&ahb_gates 8>, <&mmc0_clk>;
>> > -                       clock-names = "ahb", "mmc";
>> > +                       clocks = <&ahb_gates 8>,
>> > +                                <&mmc0_clk>,
>> > +                                <&mmc0_sample_clk>,
>> > +                                <&mmc0_output_clk>;
>> > +                       clock-names = "ahb",
>> > +                                     "mmc",
>> > +                                     "sample",
>> > +                                     "output";
>>
>> Just a stylish nitpick. All the other resources in these files
>> are listed inline if possible, not one phandle/value per line.
>
> Look at the PIO interrupts, every USB PHY resources, etc. ;)

I guess we need some styling cleanups. :)

ChenYu
