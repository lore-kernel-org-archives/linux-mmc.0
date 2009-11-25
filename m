From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v4][mmc/host]:Blackfin SD Host Controller Driver
Date: Wed, 25 Nov 2009 17:25:20 -0500
Message-ID: <8bd0f97a0911251425q178993fete79b675e2730bdec@mail.gmail.com>
References: <1259162390-378-1-git-send-email-cliffcai.sh@gmail.com>
	<20091125140422.cdee4a0d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:55380 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759124AbZKYWZd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2009 17:25:33 -0500
In-Reply-To: <20091125140422.cdee4a0d.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cliffcai.sh@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cliff.cai@analog.com, Bryan Wu <cooloney@kernel.org>

On Wed, Nov 25, 2009 at 17:04, Andrew Morton wrote:
> On Wed, 25 Nov 2009 23:19:50 +0800 cliffcai.sh wrote:
>> +struct dma_desc_array {
>> + =C2=A0 =C2=A0 unsigned long =C2=A0 start_addr;
>> + =C2=A0 =C2=A0 unsigned short =C2=A0cfg;
>> + =C2=A0 =C2=A0 unsigned short =C2=A0x_count;
>> + =C2=A0 =C2=A0 short =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x_modify;
>> +} __attribute__((packed));
>
> __packed is preferred.

we should move this into the Blackfin dma.h at any rate

>> +static void sdh_start_cmd(struct sdh_host *host, struct mmc_command=
 *cmd)
>> +{
>> + =C2=A0 =C2=A0 unsigned int sdh_cmd;
>> + =C2=A0 =C2=A0 unsigned int stat_mask;
>> +
>> + =C2=A0 =C2=A0 dev_dbg(mmc_dev(host->mmc), "%s enter cmd: 0x%p\n", =
__func__, cmd);
>> + =C2=A0 =C2=A0 WARN_ON(host->cmd !=3D NULL);
>> + =C2=A0 =C2=A0 host->cmd =3D cmd;
>> +
>> + =C2=A0 =C2=A0 sdh_cmd =3D 0;
>> + =C2=A0 =C2=A0 stat_mask =3D 0;
>> +
>> + =C2=A0 =C2=A0 sdh_cmd |=3D cmd->opcode;
>> +
>> + =C2=A0 =C2=A0 if (cmd->flags & MMC_RSP_PRESENT) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdh_cmd |=3D CMD_RSP;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat_mask |=3D CMD_RESP_=
END;
>> + =C2=A0 =C2=A0 } else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat_mask |=3D CMD_SENT;
>
> Arguably wrong from a coding-style POV and looks weird IMO. =C2=A0Add=
s a bit
> of risk that subsequent coders will think they're writing in python a=
dn
> will add bugs.

i dont really get what you're referring to here.  the code in question
looks ifne to me, and i dont see anything "python-esque" about it

> Fixes:
>
> - =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 } else }

guessing you actually meant '{' there
-mike
