From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH] mmc: core: add the warning message when card didn't
 support HPI
Date: Sat, 10 Mar 2012 01:33:15 +0900
Message-ID: <CAELcNGQNzYAE8HAfM74=+Db8BKRscRXz-wgXn_DPmGiO0QFeRg@mail.gmail.com>
References: <4F59BE26.8070705@samsung.com>
	<m2r4x1or4q.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566Ab2CIQdQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 11:33:16 -0500
Received: by bkcik5 with SMTP id ik5so1286093bkc.19
        for <linux-mmc@vger.kernel.org>; Fri, 09 Mar 2012 08:33:15 -0800 (PST)
In-Reply-To: <m2r4x1or4q.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Chris.

Sorry..i will resend the patch after fixed.

Best Regards,
Jaehoon Chung

2012/3/9 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Fri, Mar 09 2012, Jaehoon Chung wrote:
>> Though card didn't support HPI,someone could use the send_hpi_cmd().
>> Then maybe didn't work fine.
>> Because card->ext_csd.hpi_cmd didn't set.
>> So if card didn't support hpi, return the waring message.
>>
>> And CMD12's flags is MMC_RSP_R1B.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A08 +++++++-
>> =A01 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 4d41fa9..395f944 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -556,9 +556,15 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32=
 *status)
>> =A0 =A0 =A0 unsigned int flags;
>> =A0 =A0 =A0 int err;
>>
>> + =A0 =A0 if (!card->ext_csd.hpi) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_waring("%s: Card didn't support HPI com=
mand\n",
>
> This isn't going to compile. =A0Please compile test patches before se=
nding
> them.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostna=
me(card->host));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 opcode =3D card->ext_csd.hpi_cmd;
>> =A0 =A0 =A0 if (opcode =3D=3D MMC_STOP_TRANSMISSION)
>> - =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>> + =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MMC_RSP_R1B | MMC_CMD_AC;
>> =A0 =A0 =A0 else if (opcode =3D=3D MMC_SEND_STATUS)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
