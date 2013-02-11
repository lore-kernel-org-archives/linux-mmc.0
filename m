From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 0/5] mmc: core: Signal voltage switch procedure for UHS mode
Date: Mon, 11 Feb 2013 14:18:24 -0500
Message-ID: <878v6upslb.fsf@octavius.laptop.org>
References: <1359382108-958-1-git-send-email-johan.rudholm@stericsson.com>
	<87y5eustxu.fsf@octavius.laptop.org>
	<CA+20K0DQYO3hODLRb-ibqdfmxUZP1u_mjtbT04JzK2uMk4r9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44553 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759270Ab3BKTSh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Feb 2013 14:18:37 -0500
In-Reply-To: <CA+20K0DQYO3hODLRb-ibqdfmxUZP1u_mjtbT04JzK2uMk4r9bw@mail.gmail.com>
	(Johan Rudholm's message of "Mon, 11 Feb 2013 20:09:31 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Wei WANG <wei_wang@realsil.com.cn>

Hi,

On Mon, Feb 11 2013, Johan Rudholm wrote:
>> Thanks, pushed to mmc-next for 3.9.
>
> Cool! Just so we won't forget and break something, have you considered
> taking in the following patch too?
>
> From fc6069b79203f64e7efa8dd0bb295bebcd22f710 Mon Sep 17 00:00:00 2001
> From: Kevin Liu <kliu5@marvell.com>
> Date: Fri, 14 Dec 2012 16:44:10 +0800
> Subject: [PATCH v3 3/3] mmc: sdhci: update signal voltage switch code

Ah, thanks for the heads-up.  I've pushed this one now too, and will test.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
