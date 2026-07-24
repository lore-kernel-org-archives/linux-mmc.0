Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D853E5585
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883575; cv=none; b=gs2pNbyw4sctifGnqQuAPpRi4ehhsw9SfiaLQAqwWN4L8OlLa3MJ8AYqfmUIPpfLurVA928BzqX3yYYC8LTxsbu5skRgOJK+bHZfY0QAOSVavuuefwnWG5Mo+07ST5yb/ANM2yJ9R73+XRAtDdaCEQG55QmmOUJrbUYs4bJxTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883575; c=relaxed/simple;
	bh=Hr21Ef44C0/l40hmrk4Hk5UG55mypQWcs3OpQwMQF48=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LFEYnLc8XwKCUz7N6NqkyL/uUs9SQxfUagVjRwghdJ5rKsKQ/zWRyaaQkc/8ridGTSx2qya0KLAMECgIPYI3Sr6kwGT8e85GTGi/31RhoQ0uLsMQ6dqRGm0lRTkklS2yztKu7E4StxaSSSYhG4l8BanbTBAm7CUs6uq3xXGhFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FWBta0Du; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d53tylHq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FWBta0Du";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d53tylHq"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lLOA2276409
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 08:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SyOBQsoBBSbgjvpJBtVfWA1ADD8DzVhTrrX4jNO1Klw=; b=FWBta0Du1TQITriF
	OQi0m9KBPmKgQ0PDkUsFJC9+v0Hm4LOm2hNsEHUBIdW4XEFugNjuoA7RZ5JCbjRz
	zsAdd5lsgtTTQoRrZFovAlBLGiTJg6cbbPUVv8ZBvMeVzQmsQy2cmMUMQKhk+ypR
	dBEzSj6xbcqAj4OoMVC0wb09PmLLTq6LhTJc2yEKCWo9h6GBGtOlKZP+yDMUfL4X
	xVmLNinuM2Bu61YG/aTHsyzaZPBjuSWlcqVJKsTOsKdoCqdABhpylWOSUYHywgU5
	NAl3sQoBjS3vnkmZue9r84AHAyAi4cpVX3KvvR1S6ls2DLJ5cUPYmpPYkR/KcbQ6
	wmmI6A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0axyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 08:59:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso145275a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784883572; x=1785488372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:references:cc:to:subject
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SyOBQsoBBSbgjvpJBtVfWA1ADD8DzVhTrrX4jNO1Klw=;
        b=d53tylHqYjSJ7GAOaFSoKJzhvTOEarl6YhpMqQUJ4jNeP9EV1elhufSMVovaY6pXQF
         fFClB0P5C+sTkabY5GmVbP2PXUeVAHnZufkQJBNXRFCrcbrSMVLhnpP8TxIjGaRbdbJv
         ISVAm7qF/uzYId9IQnlcxc69LW1fFZyTx1rJd1MHAGMlI4jrXuVawgWYnriwY4HHuQtv
         TiJIlK/H5ppLjgji+XQaGyjfbmnbiwXIMyKYnHEeyL3YZS07Sq2DqLKfOBD0kRuFWtIZ
         jvKg6FnoKgjQdT763WRsE02H7DqD2iMdEeI3+NVPqEQq3FEMldg4nM8dSH8XSRkLJHKU
         C8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784883572; x=1785488372;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:references:cc:to:subject
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SyOBQsoBBSbgjvpJBtVfWA1ADD8DzVhTrrX4jNO1Klw=;
        b=RQhPg71B45jvEqk/J+//lN1fPL1nao9hVYRufhbKJvdnfDwIWg4aZIB7Ozok4BL+kG
         s7DCPR+oe0sFudaxnmzQI1nMM+wgzPZuvqIlG73d/mxbXJS3+Zxsg4hn6uBNcqNJj2dY
         GPrzr8DtJKWVzf2DKqNZgfGfHP9ykNe2VLbl+GMSjoT0jk/RP3ZpZc3+WIS490LDq7rX
         ATba+5HcerDR5CHU3pulXJjBHBBmSK+ZPdhc3zbriLdA75IRbbyh1NRgIxIOJxjGFjKJ
         zqedxj4VGiDI/krQ3ApFmpF6OL8KTu6DxFZjrd6eDKHimTFap69iP6rooGnNpmKPfje1
         gulw==
X-Forwarded-Encrypted: i=1; AHgh+RobmOIJt0+iVjCIf34ytq/JQb4F4odubauZjhv5oMZ/AqMsV3PHl9mOgdVmA1QunjraQfFCAIDHGKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQgT0Fs5LJ/0MnnwyLW/SXxUECiPcQBmQ9F4p15Xcd2gDNPaku
	A74jfZCF5JZ/grrKWVrAFTavVkvWsjzZ0Okyl1Fbo2t7o6SQxskcN75PB+Hkgb4qTsNkPH25HRz
	qIpWBxH7J8HqRx5/D/ysc+waJ5Xf7DunEKogd8HLqbnHkpMd6w+0+fQ/3s7pBco4=
X-Gm-Gg: AR+sD12tO8RFi5H5PY9UgiwGVDD6Ef7azHUa78k0msIcj95cSf+qpnO+vXZBaCqOCJr
	a33u23uwwuvRrOUaUX7pYbl3RlcVCzpZcuT+0qWBsku8iOXoMLFMsgYfFfiwj2vMREKvdrmGU23
	oqtY1YBVjRL5c44zJnEZNLtO1Sl5Zm/A5qmYm7tFzrxqZRAVQCq3nh1y2tg3jheRgA0K86bnTqR
	tCY/8DxKdfe2rZ/AGLurQoGRi/zkolxdnlQaszdLuozmBPJzbpyE3PoNpX+UHoroIiyP3l8Kt1T
	N/t0iVR4hNfvGpfJ/fdTd2sfokLxldnBPg+8Uc5+H6N8FPceX7JcD2WojbtOlaHvjWcIvtNsiTR
	mbiWFU7sG4V6ssM84hqrRVQlhV1E=
X-Received: by 2002:a05:6a20:c79a:b0:3bf:a698:ce4d with SMTP id adf61e73a8af0-3c44b244083mr7319276637.54.1784883572471;
        Fri, 24 Jul 2026 01:59:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:c79a:b0:3bf:a698:ce4d with SMTP id adf61e73a8af0-3c44b244083mr7319243637.54.1784883571908;
        Fri, 24 Jul 2026 01:59:31 -0700 (PDT)
Received: from [10.218.4.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0eb2edsm4048097a12.9.2026.07.24.01.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 01:59:31 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Subject: Re: [PATCH v4] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Eric Biggers <ebiggers@kernel.org>,
        adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com>
 <CAPDyKFrOHqStZbsye9Quk71UGkzUxOkwG9yAGYFVvt+=nMJSyw@mail.gmail.com>
 <20260122011417.GB946159@google.com>
 <CAPDyKFoPVeu3xe7ZAxBTNFfHmf=f7OZ3iUG=pRG8mD=UOGNVPA@mail.gmail.com>
 <3e04735c-ce0c-b2b6-508d-57ec363b8894@oss.qualcomm.com>
 <625d16ec-052b-dfb2-61f4-bf0404297f28@oss.qualcomm.com>
 <CAPx+jO8rUwYV6q1-RrA4aZ9XnomSf82fgf8Jh2fUC0fE03RFPw@mail.gmail.com>
Message-ID: <4fe3977f-74a6-e74e-b217-2b07e4ad1151@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 14:29:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPx+jO8rUwYV6q1-RrA4aZ9XnomSf82fgf8Jh2fUC0fE03RFPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HIXjglvQuhMLJcrAZcgudGZ-S4Zuzwpg
X-Proofpoint-GUID: HIXjglvQuhMLJcrAZcgudGZ-S4Zuzwpg
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a632975 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Y-QaNR4vB-fFdNo4IRoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4MSBTYWx0ZWRfX1JIFufL05VGy
 3HLK+5tJ9Bz+VV6cOo8uTzdUgQxdc+7P7yE0/P7uF7sZhFvxZfSIZIO958J+qvrdl/D11uikYY1
 4LdlFX5KSN5AvpZW666T6KGGMu35iPX7REBdfzy5O523r9lD4tBiV/EqtNRz68PZD4TVXrOUWf6
 iul9oYm3iVHPoM390ALgbYpjUJArDQC9VhJTWS3mMvKuI/0UtKMO/YVNBbEQIeG5xixJbnVJ+lo
 ThBdLu5SNVsXXNzXXcq6jEExIWJzVPgusXWcuGJ1plS40e3bDI03S43xnDvt1DxpBybXWK1+Wfp
 wO1g1t69txlznzQf6lfEdg9cy83mRWt8hkibOyPMBAVzYRNbqfRa2xDlKFd2awqXoq3kP9zXFp5
 DDA8QsHUQ5/tyJvv85x06kobFfZjK2BjEo6OKAgVaKafHVQZWEw8yqKx/FkIZYM8xuSMy+CH9JL
 GXAEsJSf9/KWtGfXdTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4MSBTYWx0ZWRfX6FoCJGTWBb0e
 NhyC4UkIIl9f2HDaUmWKKp3U4T1S2UmB2oZ07yCf1DgV9Fs+sAQpTFUekNDIyxI8OmbzTNoTcHi
 91PK77fSnKa98sjRgagHJlX9sjyZ45Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240081



On 7/6/2026 6:30 PM, Ulf Hansson wrote:
> On Wed, May 20, 2026 at 12:50 PM Neeraj Soni
> <neeraj.soni@oss.qualcomm.com> wrote:
>>
>> Hello Ulf,
>>
>> Can you please help to clarify? If there is no more modifications expected
>> then wanted to understand when this patch can be picked for mmc-next.
> 
> Apologize for the delay. See more comments below.
> 
>>
>> Regards
>> Neeraj
>>
>> On 5/14/2026 11:26 AM, Neeraj Soni wrote:
>>>
>>>
>>> On 1/22/2026 3:44 PM, Ulf Hansson wrote:
>>>> On Thu, 22 Jan 2026 at 02:14, Eric Biggers <ebiggers@kernel.org> wrote:
>>>>>
>>>>> On Wed, Jan 21, 2026 at 03:12:43PM +0100, Ulf Hansson wrote:
>>>>>>> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
>>>>>>> index fec4fbf16a5b..a5a90bfc634e 100644
>>>>>>> --- a/drivers/mmc/core/crypto.c
>>>>>>> +++ b/drivers/mmc/core/crypto.c
>>>>>>> @@ -15,7 +15,7 @@
>>>>>>>  void mmc_crypto_set_initial_state(struct mmc_host *host)
>>>>>>>  {
>>>>>>>         /* Reset might clear all keys, so reprogram all the keys. */
>>>>>>> -       if (host->caps2 & MMC_CAP2_CRYPTO)
>>>>>>> +       if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
>>>>>>>                 blk_crypto_reprogram_all_keys(&host->crypto_profile);
>>>>>>
>>>>>> As far as I understand, calling blk_crypto_reprogram_all_keys() would
>>>>>> only be needed for those mmc hosts that lose their corresponding ICE
>>>>>> context during runtime+system suspend, reset and possibly during
>>>>>> ->probe().
>>>>>>
>>>>>> In other words, calling mmc_crypto_set_initial_state() from
>>>>>> mmc_set_initial_state() looks like it's a mistake, as it has really
>>>>>> nothing to do with the card's initialization, unless I have understood
>>>>>> this wrong!?
>>>>>>
>>>>>> That said, I would rather make the mtk-sd and sdhci-msm drivers to
>>>>>> handle this themselves, by explicitly calling
>>>>>> blk_crypto_reprogram_all_keys() when needed - and drop
>>>>>> mmc_crypto_set_initial_state() altogether.
>>>>>>
>>>>>> For the sdhci-msm case, it seems like the only case we need to care
>>>>>> about is for the reset.
>>>>>>
>>>>>> For mtk-sd I don't know what is needed, but possibly Eric can help out here?
>>>>>
>>>>> The comment for mmc_set_initial_state() says "Set initial state after a
>>>>> power cycle or a hw_reset."  I relied on that when I added the call to
>>>>> mmc_crypto_set_initial_state() back in 2020.  In the following thread it
>>>>> was also discussed that the code was intended to reprogram the keys on
>>>>> reset, not runtime suspend as that shouldn't be needed:
>>>>> https://lore.kernel.org/linux-mmc/X7gQ9Y44iIgkiM64@sol.localdomain/T/#u
>>>>
>>>> The comment in the mmc_set_initial_state() is referring to the card
>>>> and not the host controller. There have been some similar
>>>> misunderstandings in the past for other functions in the core, sorry.
>>>>
>>>> In any case, I have been trying to understand where the ICE context
>>>> really belongs and recently Neeraj answered that question [1].
>>>>
>>>>>
>>>>> If that is not what it actually does, it probably would be appropriate
>>>>> to replace it with something else.
>>>>
>>>> I agree, the comment(s) could deserve some clarifications.
>>>
>>> Hello Ulf. Do you expect modifications in the comment for mmc_set_initial_state()?
>>> I am sorry i did not follow up and assumed that no more changes are expected in
>>> the patch but i stil see it is not yet reviewed or approved.
> 
> There are a couple of things needed to get this merged.
> 
> 1) Please split up the patch into two pieces. Let the core change be a
> separate patch preceding the change to sdhci-msm.

Ack.
>
> 2) Clarify in the commit messages that the register context for the
> crypto profile belongs to the sdhci/cqhci host and not the mmc card,
> hence re-programming should be managed by the host driver itself.
> Typically that should be done from the driver's runtime suspend/resume
> callbacks, even if that isn't needed for sdhci-msm, it seems.
> 
Ack. Yes this is not needed for sdhci-msm.

> 3) To avoid breaking the support for mediatek drivers, I agree that
> adding MMC_CAP2_CRYPTO_NO_REPROG as proposed, makes sense as an
> intermediate step. We can look into the mtk-sd driver later on and
> clean things up properly.
>
Okay.
 
> 4) The call to blk_crypto_reprogram_all_keys() that's added to
> sdhci_msm_gcc_reset(), gets called once during ->probe(), is that
> sufficient then? In any I would prefer that we don't use "#ifdef
> CONFIG_MMC_CRYPTO" more than needed in the code, so  please, either
> add a new function within the existing section along with a stub
> function or - if it works, call blk_crypto_reprogram_all_keys() from
> sdhci_msm_ice_init() directly instead.
>
Ack. Yes the intention is to re-program the keys only if the host undergoes
hardware reset. I will post v5 with the clean up you suggested.
 
> Kind regards
> Uffe
> 
Regards,
Neeraj
