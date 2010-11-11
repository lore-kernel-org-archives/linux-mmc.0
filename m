From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 1/1]sdhci-pxa: support tune_timming for various cards
Date: Thu, 11 Nov 2010 10:08:25 +0800
Message-ID: <AANLkTiniVAFJiLFqtrAiWyq7N=JKZaCuEhupP4DQoqTd@mail.gmail.com>
References: <AcuAtXvv47budpVyQx2uoWC0YAvjJw==>
	<E8C182D3-90EE-4A2B-BE63-905E85F9AF54@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45084 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab0KKCI0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 21:08:26 -0500
Received: by fxm16 with SMTP id 16so978557fxm.19
        for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 18:08:25 -0800 (PST)
In-Reply-To: <E8C182D3-90EE-4A2B-BE63-905E85F9AF54@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Miao <eric.y.miao@gmail.com>

On Wed, Nov 10, 2010 at 4:58 PM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> <snip>
>
>> +#define SD_CLOCK_AND_BURST_SIZE_SETUP =A0 =A0 =A0 =A0 =A00x10A
>
> This offset is only for MMP2. =A0On other pxa processors use a =A0dif=
ferent offset. =A0sdhci-pxa.c needs changing to support other pxa soc c=
hips.

The first stage is only considering MMP2, the next step wil consider
other processor, for example move private register to arch/

>
> The value only needs setting at initialization time or sdhci reset (R=
ESET_ALL)
it is OK to put here, then no call back is needed.
>
>
>
