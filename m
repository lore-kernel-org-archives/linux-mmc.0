Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681181;
	b=I00rvBTvCMTJeXdcvbmjfKUYSz3U8UDIpuREXx0qTKjZwb7o5jKgeWjVtmVFOwdGvIru
	 zfNPNjH+//K4HxxA/3BpE4CG+2J/Bk9+wbtI3iGapfswELLjqgtVqeILsyAvgPpe3vZt5
	 OnxtjJ5NX/8FnW4wtyAeBWKlNmGeamq/oC/KJw4TUR9a9k8X596qrCZ8v3pMyf/eN7b13
	 5muAV8CCORGnPksLoHi7PhdRCMJETpleRODkTus6BEOVYMF0ZhoAih9YjH+fKsonhjJoL
	 otpP3B3u06IQTbNAuegCtwZ7bg5uGZgFi54857aT/10t6tfPzsN7FZJkAVIPpF5d36Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681181;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=i+O5j7PZfr4iD4slJ2jWbDUp+JD9owIXTs/pkOPPSP4=;
	b=2U8axyvisdFZb7m4BxhOdmG8QB1ImkHIUqKziIC+sMwmpyqDiEmwIUQA+zUaXnRWsV0B
	 q1JVzeMiJfzdm+YzDN6tV8EWmzDbb8QqzAfg/gJtaJjS+eR9C49QE8XJEXc0mKGZyP30D
	 K9rWBBlyw29dLMfOU/lwjllc5Z0DXYJYg4hMXmdv1OfKLFD0M0DcJymcJ4qMm80/RoQrq
	 Gj8nT9fFqeZ5B1AC4Mn23tYZtrTe6iWAZoyIeOFIRRWLG9WOQac4Z7+BHPwpxVhZrSeo3
	 U3/CR0vdJwlqqjiGaznsHWKu5gklCLT0Q5jBBUQbmiZGS+YfBpeZ+uCBR8WC9P9KxNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=BGopDR8G;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F3606A329
	for <linux-mmc@vger.kernel.org>; Sat, 14 Nov 2026 18:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 067F3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=BGopDR8G
DKIM2-Signature:  i=1; m=1; t=1794681177;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:lG800i9K7SqWzD35pkTvinlzn6pE
   JPTvnMUJjNrtpAtczYzoX7pQRlOEcAFcZ6LY/5UnBXHbmPIK0YbRihCnvqb/jRhD2Lzf1jg7pS3
   zoL4mrxm8QC+HidGHi0Xr6eJK15Cj169C7KZRWmzXpGUWSaxSLc8RGi0fuWyXXe+kQ8ZfoTh6QS
   mQrrFZRdrYwdrgzf3g7KXiA/3As3bnUdmfor5XoiQl6iVL6PSOpuVBbIPsA+ttNRHJhdj/k4WkW
   0bjh+c3FeUWFUUtIwW8zPYInpVKL/36rIBpBf3Eg1ylD3wcSia8WHMI3pyOCMqPS7ZjCUMWZMVa
   Sky2S8TGeyGi2g==;
Message-Instance:  m=1;
 h=sha256:
   ohHntuO4RAEBGH7Qweqero3dfy2IZxSHajP7Eb8I+WI=:
   SKxqiI/BUt3d724rCFsfmg33/a2rhvNZBrT/FsroPzI=,
  sha512:
   FcuCwUCIAgNjmnmRY91JZyF10EsMJ9LK7c66w9QrVyp+XUrKQkxgpTJ4sEKOLyKZiTOaO/LzvOXFDB1IPh1DHQ==:
   rcTJYdZSKgdkVLNfhi1VmpozNkcCPjq8Wyg2WghNSI9aRXsNeY+9WStT8tLMKAgtMhnHowejTeVqfkDo+hIs8g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794681158; x=1795285958; i=wahrenst@gmx.net;
	bh=i+O5j7PZfr4iD4slJ2jWbDUp+JD9owIXTs/pkOPPSP4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BGopDR8GWdKpU1WKsng2ujTEjy/bYycxztHjXOf+21+w4F9NFiuuQDrMsPyIbSQY
	 nlGe7foxK58lIisKF8i8fCfeRF5NpU3ia6mDtR/j/c7B7TxN0rVqx9n+LV1n63ZW2
	 4vpp+P3SLv4hCKJT/6Bge7h4dcWwCJKPAj92s37IWRcyu12Gmu6FzNMj2+AKNfPWo
	 VVWtgp6+ffSPnMFzSdh+9afUFDxBdJkkZqBDa5qRJ7VXAO0Pz/kGN9lC1433mB5ZS
	 OilZgXPFZfhI6OdfDWZ0V/6di2nhhIiOwgBbXbwk7rRnIYfL6S4hmhdlZ8EiRiJB0
	 mrOl3NYD2aNgG5m2BA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5eR-1xC96x2amb-00Ob8f; Sat, 14
 Nov 2026 19:32:38 +0100
Message-ID: <fcfc5d38-2755-445c-8444-bd4c5b9c524f@gmx.net>
Date: Sat, 14 Nov 2026 19:32:34 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: bcm2835: restore scatterlist after DMA setup failure
To: Artem Novak <artem122novak@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Hemanth Selam <hemanth.selam@gmail.com>, John Garry <john.garry@linux.dev>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20261114051011.275554-1-artem122novak@gmail.com>
 <132b7ffc-c1b7-4adb-ac66-6f40cc512048@gmx.net>
 <CAPufuhZLT2QM+i97zETYCVs2jRBT0enf+zo+CiiSoiVseOUnmg@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CAPufuhZLT2QM+i97zETYCVs2jRBT0enf+zo+CiiSoiVseOUnmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VeW5E0dmPUTQUXOgoGHMfeHH/7XI2reuI5q/rDS990jyc3gf5aX
 nq4GsLRWGCiwlkHJHY9YviE8s1R9KEryXS2hsq+edBmKGRsdatu+pm/o+8yfGeG3RyZw/ID
 rMZCwpUW4aoLnIA88Lqa9wFH31aeX9VtiVIqaNQVm+2TrT9LV6QO3jh4A1XKbvjNSoWwmMs
 S8BxC8e7cfiy7s2ZZ3a6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y6J5/GM461M=;uIym+8QChNCoBWnP7//yqCS7Y3c
 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
 gEB7hjcJ37X3Rsn7M6mnyJz+/UP4zoTFmD8sRw==

Hi Artem,

Am 14.11.26 um 19:16 schrieb Artem Novak:
> Greetings.
>
> Yes. If DMA setup fails, the request falls back to PIO with a
> shortened scatterlist entry.
> This can cause the PIO transfer to omit part of the data,
> potentially resulting in corrupted or incomplete I/O.
>
> I had a kernel panic while running my Raspberry Pi server,
> which made me find this problem.
please add these important information into the commit message. Just a=20
hint for the future, please try to avoid top-posting on the kernel=20
mailing lists.
> For trimmed_sg:
> I kept trimmed_sg to explicitly track the scatterlist entry whose
> length was modified.
> original_len alone tells us the previous length, but not which entry to =
restore.

Sorry, I didn't look properly. Please ignore this part.

Thanks

>
> Best regards,
> Artem
>
> On Sat, Nov 14, 2026 at 3:50=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net>=
 wrote:
>> Hi Aartem,
>>
>> Am 14.11.26 um 06:10 schrieb Artem Novak:
>>> The DMA preparation path shortens the final scatterlist entry
>>> to reserve space for FIFO drain words.
>>>
>>> If DMA mapping or descriptor preparation fails, the request
>>> falls back to PIO, but the shortened scatterlist entry is left
>>> unchanged. Restore its original length and clear drain_words
>>> before returning to the fallback path.
>>>
>>> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost cont=
roller.")
>>> Signed-off-by: Artem Novak <artem122novak@gmail.com>
>> are there real potential negative consequences? I'm asking because ther=
e
>> is a fixes tag.
>>> ---
>>>    drivers/mmc/host/bcm2835.c | 13 ++++++++++++-
>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
>>> index efd1903c3ccd..49a975e984df 100644
>>> --- a/drivers/mmc/host/bcm2835.c
>>> +++ b/drivers/mmc/host/bcm2835.c
>>> @@ -449,6 +449,8 @@ static
>>>    void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data=
 *data)
>>>    {
>>>        int sg_len, dir_data, dir_slave;
>>> +     struct scatterlist *trimmed_sg =3D NULL;
>>> +     unsigned int original_len =3D 0;
>>>        struct dma_async_tx_descriptor *desc =3D NULL;
>>>        struct dma_chan *dma_chan;
>>>
>>> @@ -480,6 +482,8 @@ void bcm2835_prepare_dma(struct bcm2835_host *host=
, struct mmc_data *data)
>>>                for_each_sg(data->sg, sg, data->sg_len, i) {
>>>                        if (sg_is_last(sg)) {
>>>                                WARN_ON(sg->length < len);
>>> +                             trimmed_sg =3D sg;
>>> +                             original_len =3D sg->length;
>>>                                sg->length -=3D len;
>>>                                host->drain_page =3D sg_page(sg);
>>>                                host->drain_offset =3D sg->offset + sg-=
>length;
>>> @@ -495,14 +499,21 @@ void bcm2835_prepare_dma(struct bcm2835_host *ho=
st, struct mmc_data *data)
>>>                                     &host->dma_cfg_tx);
>>>
>>>        sg_len =3D dma_map_sg(host->dma_dev, data->sg, data->sg_len, di=
r_data);
>>> -     if (!sg_len)
>>> +     if (!sg_len) {
>>> +             if (trimmed_sg)
>>> +                     trimmed_sg->length =3D original_len;
>> Maybe I missed something, but why do we need trimmed_sg? Can't we just
>> check original_len instead?
>>
>> Best regards
>>
>>> +             host->drain_words =3D 0;
>>>                return;
>>> +     }
>>>
>>>        desc =3D dmaengine_prep_slave_sg(dma_chan, data->sg, sg_len, di=
r_slave,
>>>                                       DMA_PREP_INTERRUPT | DMA_CTRL_AC=
K);
>>>
>>>        if (!desc) {
>>>                dma_unmap_sg(host->dma_dev, data->sg, data->sg_len, dir=
_data);
>>> +             if (trimmed_sg)
>>> +                     trimmed_sg->length =3D original_len;
>>> +             host->drain_words =3D 0;
>>>                return;
>>>        }
>>>
