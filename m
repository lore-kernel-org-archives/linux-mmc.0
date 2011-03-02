From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Remove set-but-unused variable.
Date: Wed, 02 Mar 2011 11:55:09 +0900
Message-ID: <4D6DB18D.3080006@samsung.com>
References: <1298930137-15105-1-git-send-email-cjb@laptop.org>
 <AANLkTimqBMmpT_vr+UHjkwzHGOJEKaNeUKLw0VZRnWjr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16571 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757201Ab1CBDHO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 22:07:14 -0500
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHE003NATFZ8K40@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 02 Mar 2011 11:55:11 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHE00IQGTFYIH@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 02 Mar 2011 11:55:11 +0900 (KST)
In-reply-to: <AANLkTimqBMmpT_vr+UHjkwzHGOJEKaNeUKLw0VZRnWjr@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Will Newton wrote:
> On Mon, Feb 28, 2011 at 9:55 PM, Chris Ball <cjb@laptop.org> wrote:
>> count is only ever used by assigning to old_len if count =3D=3D 0, a=
nd
>> then old_len isn't ever used at all.  So, both are redundant.  Fixes=
:
>>
>> drivers/mmc/host/dw_mmc.c: In function =91dw_mci_read_data_pio=92:
>> drivers/mmc/host/dw_mmc.c:1034:32: warning: variable =91old_len=92 s=
et but
>> not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: Chris Ball <cjb@laptop.org>
>> Cc: Will Newton <will.newton@imgtec.com>
>=20
> Looks good, thanks for fixing this!
>=20
> Acked-by: Will Newton <will.newton@imgtec.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

