Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51441C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Nov 2021 14:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhK3O2v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:28:51 -0500
Received: from smtp.220.in.ua ([89.184.67.205]:51509 "EHLO smtp.220.in.ua"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236374AbhK3O2v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 30 Nov 2021 09:28:51 -0500
Received: from [10.30.18.189] (unknown [149.255.131.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id F0F891A20D5B;
        Tue, 30 Nov 2021 16:25:27 +0200 (EET)
Message-ID: <6864fb7a-aa1a-c2d8-e494-60779cf80326@kaa.org.ua>
Date:   Tue, 30 Nov 2021 16:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4] mmc-utils: Use printf() to extract and print fw
 version
Content-Language: uk-UA
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
        Chris Ball <chrisball@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20211116105109.3830-1-oleg@kaa.org.ua>
 <20211129154826.23595-1-oleg@kaa.org.ua>
 <DM6PR04MB657569E423F95B4151E56C80FC679@DM6PR04MB6575.namprd04.prod.outlook.com>
 <42135dd8-c326-7607-acc9-3d55e9b98dad@kaa.org.ua>
 <CAPDyKFqrTvV5BSerNwXT4tQNWwFdSZferccdMWGOe_RCC8hkCg@mail.gmail.com>
From:   Oleh Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <CAPDyKFqrTvV5BSerNwXT4tQNWwFdSZferccdMWGOe_RCC8hkCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Ulf,

30.11.21 14:14, Ulf Hansson пише:
> On Tue, 30 Nov 2021 at 13:07, Oleh Kravchenko <oleg@kaa.org.ua> wrote:
>> Hello Avri!
>>
>> 30.11.21 09:42, Avri Altman пише:
>>> Hi,
>>>> This patch also fixes a compile error with a newer version of GCC:
>>>> error: '__builtin_strncpy' output may be truncated copying 8 bytes from a
>>>> string of length 511 [-Werror=stringop-truncation]
>>> You are reverting commit 0eea71e4f2 (mmc-utils: Fix for Firmware Version string printing).
>>> Please use git revert and add an explanation in your commit log.
>> I'm not reverting this commit.
>> It's similar but not.
> Right, this time we limit the print to 8 chars, which avoids garbage
> from a non-NULL terminated string.
>
> Perhaps we should add (similar to what we do for kernel commits):
> Fixes: 0eea71e4f22a ("mmc-utils: Fix for Firmware Version string printing")

Good point!

>
> [...]
>
> Kind regards
> Uffe
