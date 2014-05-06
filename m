From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v10 00/15] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
Date: Tue, 06 May 2014 10:04:37 -0700
Message-ID: <20140506170437.5739.402@quantum>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34153 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbaEFREq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 May 2014 13:04:46 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so6139770pad.4
        for <linux-mmc@vger.kernel.org>; Tue, 06 May 2014 10:04:45 -0700 (PDT)
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>
Cc: =?utf-8?q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

Quoting Hans de Goede (2014-05-02 08:57:14)
> The first 2 patches are depenencies which should go in through the clk tree,
> Mike can you pick these 2 up please ?  :

Taken into clk-next.

> 
> "clk: sunxi: factors: automatic reparenting support"
> Is uncontroversial and has been favorably reviewed by various people.
> 
> "clk: sunxi: Implement MMC phase control"
> Is somewhat more controversial as there has been lots of discussion about
> adding a generic phase control method to the clk framework. The problem is
> that there has been a lot of talk about such a generic phase control method
> but not a single patch. Therefor I would like to move forwards with using
> a platform specific method for now. I hereby promise that once we've a generic
> method I'll write patches to convert the sunxi code to that method.

Thanks for the promise. I will hold you to it once the set_phase api is
sorted ;-)

Also thanks for the clear and concise cover letter. It is very helpful
when going through the tenth iteration of a series.

Regards,
Mike
