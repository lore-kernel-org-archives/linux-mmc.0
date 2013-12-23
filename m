From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v4 5/8] mmc: sdhci-bcm-kona: Add basic use of clocks
Date: Mon, 23 Dec 2013 00:26:01 -0800
Message-ID: <CAEPRUYphct9jJkB7kT=vqmGKX86AQMaZvhxEqChGzizGCS6d1A@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
	<1386271244-3927-6-git-send-email-tim.kryger@linaro.org>
	<CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:35335 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab3LWI0D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Dec 2013 03:26:03 -0500
Received: by mail-ee0-f54.google.com with SMTP id e51so1848025eek.41
        for <linux-mmc@vger.kernel.org>; Mon, 23 Dec 2013 00:26:01 -0800 (PST)
In-Reply-To: <CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Axel Lin <axel.lin@ingics.com>, Device Tree List <devicetree@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linaro Patches List <patches@linaro.org>

On Sat, Dec 14, 2013 at 12:14 AM, Christian Daudt <bcm@fixthebug.org> wrote:
> On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
>> Enable the external clock needed by the host controller during the
>> probe and disable it during the remove.
>>
>> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
>> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
>> Reviewed-by: Matt Porter <matt.porter@linaro.org>
>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
>
> Chris,
>  Are you ok with me pulling this patch along with the rest of the
> patchset into the bcm tree?
>
>  Thanks,
>    csd
Hi Chris,
 I'm hoping to get this patchset and "rename ARCH_BCM to
ARCH_BCM_MOBILE (mmc)" patch into 3.14 still, and these 2 patches are
waiting for your ack and confirmation that you're ok with me pulling
them through armsoc. Can you pls review them ?

 Thanks,
  csd
