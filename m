From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: add new au6601 driver
Date: Wed, 9 Jul 2014 14:52:07 +0200
Message-ID: <CAPDyKFpZVKu-uHwNfXocVb7FbgEN3NxiLHCPR38bSh_zsA4w6Q@mail.gmail.com>
References: <1399543099-31613-1-git-send-email-linux@rempel-privat.de>
	<CAPDyKFoy9DLQe1235suEwEmGSxxriBfuWSyN+ZG14OmUjrrb8w@mail.gmail.com>
	<53B3D562.1030707@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:56546 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360AbaGIMwI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jul 2014 08:52:08 -0400
Received: by mail-qc0-f173.google.com with SMTP id c9so741085qcz.18
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jul 2014 05:52:07 -0700 (PDT)
In-Reply-To: <53B3D562.1030707@rempel-privat.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

[snip]

>>
>> I am just a bit curious, does this controller support hardware busy
>> detection on DAT1 line while waiting for command completion?
>
> Do you mean AU6601_REG_BUS_STATUS?
> See at the beginning of patch.

While reviewing the code, it seems like the controller are handling
hardware busy detection on DAT1. On the other hand you don't enable
MMC_CAP_WAIT_WHILE_BUSY, shouldn't you be doing that?

Kind regards
Uffe
