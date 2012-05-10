From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 1/7] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Thu, 10 May 2012 14:42:30 +0530
Message-ID: <CAJuYYwSJ8FBQiykcyym9Gg1jVoW+rGZmjtHfy4zgcDEX6edOEA@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-2-git-send-email-thomas.abraham@linaro.org>
	<20120502095311.GZ24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63244 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799Ab2EJJMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 05:12:30 -0400
Received: by vbbff1 with SMTP id ff1so1272566vbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 02:12:30 -0700 (PDT)
In-Reply-To: <20120502095311.GZ24211@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On 2 May 2012 15:23, Russell King - ARM Linux <linux@arm.linux.org.uk> =
wrote:
> On Tue, May 01, 2012 at 10:07:40PM -0700, Thomas Abraham wrote:
>> Some platforms allow for clock gating and control of bus interface u=
nit clock
>> and card interface unit clock. Add support for clock lookup of optio=
nal biu
>> and ciu clocks for clock gating and clock speed determination.
>
> As we're moving progressively towards the common clk API, which requi=
res
> the new clk_prepare/clk_unprepare calls, new code should be using the
> dated API. =A0Please update this to do so (eg, by using clk_prepare_e=
nable()
> instead of clk_enable() for the simple solution.) =A0Better solutions
> involve decoupling the two and only using clk_enable()/clk_disable() =
where
> you really need the clock to be on.

Thanks for your suggestion. I will modify this to use the
clk_prepare_enable and clk_disable_unprepare calls for now.

Thanks,
Thomas.
