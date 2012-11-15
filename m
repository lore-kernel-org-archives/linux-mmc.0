From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Fwd: [PATCH v3 0/5] mmc: Add access to RPMB partition
Date: Thu, 15 Nov 2012 09:04:03 +0100
Message-ID: <CACRpkdaPOczX3xMA2jXPwH03oOMHmmPKO8-dAFzL-NyO2Nr1Jg@mail.gmail.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
	<CAJOk3oGMtZvrkw9ic306BKNSKCAzPQCYmJrvq5=zDi1pHjjQxg@mail.gmail.com>
	<1352927648.5856.14.camel@kkonda-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62075 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992684Ab2KOIEE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Nov 2012 03:04:04 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so788304eek.19
        for <linux-mmc@vger.kernel.org>; Thu, 15 Nov 2012 00:04:03 -0800 (PST)
In-Reply-To: <1352927648.5856.14.camel@kkonda-linux.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krishna Konda <kkonda@codeaurora.org>, Chris Ball <cjb@laptop.org>
Cc: loic.pallardy-ext@stericsson.com, linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, ulf.hansson@stericcson.com

On Wed, Nov 14, 2012 at 10:14 PM, Krishna Konda <kkonda@codeaurora.org> wrote:
> On Wed, 2012-11-14 at 12:58 -0800, Krishna Konda wrote:
>
>> The goal of this patchserie is to offer access to MMC RPMB
>> (Replay Protected Memory Block) partition.
>> The RPMB partition is used in general to store some secure data.
>> It is accessible through a trusted mechanism described in
>> JEDEC standard JESD84-A441.
>
> Hi Loic, Chris, are there any plans to merge these patchsets? I did not
> see this in mmc-next.

I was sort of wondering the same.

Krishna, could you provide your Acked-by/Reviewed-by
tag so as to convince Chris that this is a nice feature?

Yours,
Linus Walleij
