From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH v4 5/8] mmc: sdhci-bcm-kona: Add basic use of clocks
Date: Tue, 7 Jan 2014 11:37:38 -0800
Message-ID: <CAAYSxhoCrveHd5Wkc7Z0qzpGr41qG6-neYSSsuHQuC7AcuJmZQ@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
	<1386271244-3927-6-git-send-email-tim.kryger@linaro.org>
	<CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:56797 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbaAGThj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jan 2014 14:37:39 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so659841obc.7
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jan 2014 11:37:38 -0800 (PST)
In-Reply-To: <CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christian Daudt <bcm@fixthebug.org>, Chris Ball <cjb@laptop.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Axel Lin <axel.lin@ingics.com>, Device Tree List <devicetree@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linaro Patches List <patches@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

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

Chris,

Can you please provide an answer to csd?

Thanks,
Tim Kryger
