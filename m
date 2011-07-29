From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/1] mmc: Fixed bug in IDMAC_SET_BUFFER1_SIZE Macro in dw_mmc.c
Date: Fri, 29 Jul 2011 11:07:09 +0100
Message-ID: <CAFbHwiS9ESqXbHF8EnfMaMdR3JNCW+sPEtaAJvL0ptBY1OsFkQ@mail.gmail.com>
References: <1311851023-3563-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E314562.2000001@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39045 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab1G2KHL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jul 2011 06:07:11 -0400
In-Reply-To: <4E314562.2000001@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Shashidhar Hiremath <shashidharh@vayavyalabs.com>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Thu, Jul 28, 2011 at 12:17 PM, James Hogan <james.hogan@imgtec.com> =
wrote:
> On 07/28/2011 12:03 PM, Shashidhar Hiremath wrote:
>> The mask used inside this macro was assuming Buffer_Size1's[BS1's] w=
idth to be 14 bits,
>> it is actually of 13 bits, Modified masks used in IDMAC_SET_BUFFER1_=
SIZE such that
>> they use only 13 bits instead of current 14.
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>> ---
>> =A0drivers/mmc/host/dw_mmc.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 77f0b6b..f13bb49 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -62,7 +62,7 @@ struct idmac_desc {
>>
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 des1; =A0 /* Buffer sizes */
>> =A0#define IDMAC_SET_BUFFER1_SIZE(d, s) \
>> - =A0 =A0 ((d)->des1 =3D ((d)->des1 & 0x03ffc000) | ((s) & 0x3fff))
>> + =A0 =A0 ((d)->des1 =3D ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
>>
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 des2; =A0 /* buffer 1 physic=
al address */
>>
>
> Yes, according to the TRM you appear to be correct
>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>

Yes, looks correct to me too (for some reason I didn't get the original=
 mail).

Acked-by: Will Newton <will.newton@imgtec.com>
