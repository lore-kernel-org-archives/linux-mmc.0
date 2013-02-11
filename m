From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v6 0/5] mmc: core: Signal voltage switch procedure for UHS mode
Date: Mon, 11 Feb 2013 20:09:31 +0100
Message-ID: <CA+20K0DQYO3hODLRb-ibqdfmxUZP1u_mjtbT04JzK2uMk4r9bw@mail.gmail.com>
References: <1359382108-958-1-git-send-email-johan.rudholm@stericsson.com>
	<87y5eustxu.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:42396 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758472Ab3BKTJe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Feb 2013 14:09:34 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so2363793qca.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Feb 2013 11:09:32 -0800 (PST)
In-Reply-To: <87y5eustxu.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Wei WANG <wei_wang@realsil.com.cn>

Hi Chris,

2013/2/11 Chris Ball <cjb@laptop.org>:
> Hi Johan,
>
> On Mon, Jan 28 2013, Johan Rudholm wrote:
>> This patch series attempts to make the 1.8V signal voltage switch
>> required for UHS mode work according to the SD specification.
>
> Thanks, pushed to mmc-next for 3.9.

Cool! Just so we won't forget and break something, have you considered
taking in the following patch too?

>From fc6069b79203f64e7efa8dd0bb295bebcd22f710 Mon Sep 17 00:00:00 2001
From: Kevin Liu <kliu5@marvell.com>
Date: Fri, 14 Dec 2012 16:44:10 +0800
Subject: [PATCH v3 3/3] mmc: sdhci: update signal voltage switch code

otherwise I think that SDHCI may break. Kevin, please correct me if I'm wrong?

Kind regards, Johan
