Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794896727;
	b=NuXDAVZzQ5n/yOwXxX68iUV0+d58JLfmcHvrfMKlYdXmozniRqvVgWjoT0c0AZCl0NZ9
	 9QXkNzvj4456xICHJwKqWTiG9Cfb0dVBzuhHRPPmHN2uLugEf+c1MZCW/CHgjH0k+LU+q
	 PqAE231beb0BcFO7iDR8c3be9XATdQ0EMGMlzBl3xuAVSDLJd67rOX5KZCZDV81uM7ivP
	 h4h2Xdr9guygUqm/iASQpDoqYhKigkBghkNoLadQ+t0T9MUWaccgQsdK1xnaBjmpK47+F
	 b+GDjg77jV3VN0d72lFERcYkcojLOm4eRj1bcCBYcJhMDDs3EglaRh29VYS1My5eh2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896727;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5yD+WOgs/w0UEROtpGaM1H5zLUeHVWQoG0KCTRfw/gg=;
	b=ERdG7xJzkHSNNHFtR64BqluDGCDRlf2XI+Rfvv24MW3+OR8ressNYI11CmV+00UQMcAk
	 Na9Bp99X0bQ4l7B8DiS25tVrcrr0oiITxxhrUWiQwQp8W5249Eeg93HjEaLu8M/iPvexJ
	 ZU7kurEQ98rR9Qtc68L/7SYrM1mentupUN+UJtopaKmTv4loa84VDpGREhBYCw3eKjyuw
	 XLqxEIelU63foLoxBfGYFI87YlGSB3v2zxDQdepbiHsbvT3HA7lIiLzj/fgjUpjiVmNN2
	 8QgnYgwR+4uff6PgK2TAQb0qcLSCa+PIP9W+nYCWKZz+OOG3dcxK5HJCopo8vegnSwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbyetD6M;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="PlRPIE/B";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E18606A332
	for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 06:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E18606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbyetD6M;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PlRPIE/B
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH55mvp3350219
	for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 06:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yD+WOgs/w0UEROtpGaM1H5zLUeHVWQoG0KCTRfw/gg=; b=gbyetD6M55TyiFm3
	+stp9xNsuzewD6E8kFAsyawp5FF072tq6NjzsIltJ7irOevxHhCSj+ZmW9ZZzb1l
	zrPvgKQ5RXuPXSd/JDUiT0ys6YqqDTbR61RHq2zPEi9tiOu+i3OQqyi1JDbVLg9d
	5HrxoW+p+U/eH3fdc0kHyW6cwWTJ6mqhlmpqLhxFWchN3xebtE4XHvRzZ7+AY4s2
	W3S/ajc0vQbZMgK+IXbts6rotjdK482j8fv55Tj0lnwTwoFsrJbpCKnKODVcP6kD
	u2HkI0ZdLdSuCYrqs0+ePH3GlwZRx11H7b9glala1Np7gOkLzJn9UMqkv8FFmM/9
	Z/AixA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0gfr08fq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 06:25:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdd9fa2a558so4327510a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 22:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794896724; x=1795501524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yD+WOgs/w0UEROtpGaM1H5zLUeHVWQoG0KCTRfw/gg=;
        b=PlRPIE/BlbSEjGRRF3p/sf5Gr75YyDeMBhFr7+iOMzhXqi8cpoVD8XJ3vFo2PInZLv
         rPyFt+mru5NGo4boxHxjr/oHKFXKr4YSROjz79eGjJAXc9AkTg456CHzAzROygmUT2mq
         JE9VCulQSn6afpm8P3BTUF3kMJZbyEWdNKVSK3l/c36uAj7ORHiS6UQODEwyhnlxzALR
         QdEbR0woB0ZMn79hgBRsUmjzDIX4h2tVlxx7XG7o227I6aaSfMajtOJaQ02KYWrsnLyb
         4eao2jFOzq4nH+q+jrTjtpPOAYuxdFFBz/9rp1d4sXW6muiF6eqiFcn0rRGcGmnxCXLJ
         ReKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794896724; x=1795501524;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yD+WOgs/w0UEROtpGaM1H5zLUeHVWQoG0KCTRfw/gg=;
        b=jxedNLfXcOMpq2YesRhaJI5RluO9EHsCR8R1kjZaoUeSlWvVpKMT6x8U7k6U7I8zDE
         P1hMo2xWQpUBO7Yfb4ZaqfIm7XEcCdDatsgqddGzhADcERIR2UanxiQB5W1ZIxKwHWzW
         2vsLCNKfVaNgJWnkw8qGXTl8EWRK8vR+BNdItYcmu5UWIJ7GoxPRU670qSzHfxz4T0Yw
         ZEA04clhoslUTRRSUjzngYlpiplNaS2CuoTQA4GlYa3DKqtw7Yt+/jHh+CNM5tqFzJkP
         qz0U8IHoDA/0bVU/2xU/5qjr9JfltVcGiLAv5mXeG34pmukanyjuIJjmwlJh5oTB+XEv
         J2qQ==
X-Forwarded-Encrypted: i=1; AL+hErEUieQNuDqOVCp03aG69NTmgWqyBDe3Ek3J76FMmYzNls1I9LJw/IWauiDuCj4HYIQ+vjRhBOlA6mQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mChJztWymueGcU0XUYcQSBRo9hAL8VMNFNPx7ZY/Ekw9lvUN5
	mGTO59Mf2LKxGPV/ROxZ6FyFVACDLm6d1RlNYuAyUI54ysHxIMC4Xf2975byQuuYgnRe36puJMl
	mRXpqPvttEcPY6lBEJCl+nr6+9yIe7n69xP6Hl3/bvUve4DRbWtx2pEWFJnZ5TpE=
X-Gm-Gg: AZFdTZdyu6VNp+58pAtNIQPlLGE46IEY8+iKPIhnrgDKyOe4UidsbCmidlesJaYkWAC
	HA7mPoqb/uoQlamu70Ol+yqQSmOTHgMPxgbMvuOWoJTI1dH7cwJkYyG7mfg+YfjGYCRiSHHnvQz
	N8AbUenP9M8RGmS5EHKH3n9Rpsa44/NKamRuCTUPJYfKCIVfQu6G57nb9HdIBQ6OkdYE6Eh4OmP
	upoxz8detGD1A9lIPCEn5j1hBskUE39h/AN66JSO2CBQvcjPCpXkpUvHtkSDFLQ1ORXJm+to4cj
	UDyG332N23yHkqIEU3aWZD8/G3wXqAwIlcR/bM8fW64ywhZwP9nV6BojNU1u1iuioEcjXEt2h+Y
	rPYzOZDsyi7yADuwqXZHGGn6WzE3Z+XEZUp431YZPnnmYWF7ABUhEQS6LboGP8OExCAac0aCpkx
	R5cMM=
X-Received: by 2002:a17:90b:3f8e:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3b1b0b5f193mr11585565a91.66.1794896724055;
        Mon, 16 Nov 2026 22:25:24 -0800 (PST)
X-Received: by 2002:a17:90b:3f8e:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3b1b0b5f193mr11585546a91.66.1794896723403;
        Mon, 16 Nov 2026 22:25:23 -0800 (PST)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abebf1aesm2512101a91.16.2026.11.16.22.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 22:25:22 -0800 (PST)
Message-ID: <2a4f99e9-4b51-42c5-9852-8747bf8f1a14@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 11:55:17 +0530
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
Subject: Re: [PATCH v2 2/2] ufs: ufs-qcom: Enable ICE before enabling crypto
 support
To: Eric Biggers <ebiggers@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org
References: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
 <20261112-qcom_ice_pm_enable-v2-2-177e454d6f22@oss.qualcomm.com>
 <20261113040820.GE1742@sol>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20261113040820.GE1742@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X/rHu2Te c=1 sm=1 tr=0 ts=6afbf355 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=x_L3ctan3gn5YDiFMPYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: BNLqrmg8ucZS5ipMyi_YH5oZfBK1xFLN
X-Proofpoint-ORIG-GUID: BNLqrmg8ucZS5ipMyi_YH5oZfBK1xFLN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyNSBTYWx0ZWRfXxJhizytNJGU2
 aHYYJPb44R2AmddxNfXpa3dzpPoBwfECwtn5TolnBTXQIdB1iE3l51rAWnbsJbSeQjXR3kktQlT
 07UsgvsdpO3XBf8fMF6phcWjVFNtrw+ZtHFMVzGjkfuaY1UQfRdjq/mLfjSXn/Cmj6vHF1x3YwX
 6GfpiyeJvbSOTDBoMhX9/fEQV1JDXg2mt/mEaZVVryPEGA6UETI//Bv0shskrjp2DtZzYj13PFL
 4+DLF0oYLy5g7iWx7fyXwl7oxCFBo0j9HYksRWaD2hc8otI4SWkI9c08vymTSCSV6tn7QDBfQUt
 c9RZw0EJOB3jneJB60hK1HuZ0j1RZt1VWJ75YdbV2ULe4tMC0ev4SgLxaVJSDLU4vveEovmIrZS
 sF7DSEIWIjcHS1qKw9HLZqm0pGekWleL//fvK5+9pKrLqxbn5TTF6qQXThcCJ90JPp2y6AfCbWU
 V+kA2t6AgtSlTn/+fQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyNSBTYWx0ZWRfX4m3LeKcvyRzp
 tztQFt7JG+mjKheCddiI/UM9Zs0Juax9OtLdnrlK/ZV2S4f1rjIZWNXjC0EQk46r0wonOu9OHNv
 a+JkRmNXBh15fwThfELbdLzw2GwZ0Ig=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170025

On 13-11-2026 09:38, Eric Biggers wrote:
> On Thu, Nov 12, 2026 at 06:48:18PM +0530, Kuldeep Singh wrote:
>> ufs-qcom currently exposes UFS crypto profile and sets UFSHCD_CAP_CRYPTO
>> before enabling ICE. This leaves a window where blk-crypto can issue
>> keyslot programming calls before ufs-qcom has explicitly enabled ICE.
> 
> Please be more specific about what actually goes wrong, and why.  During
> probe, the crypto profile hasn't actually been registered with the block
> layer yet.  So the above seems inaccurate.  Likewise in the MMC patch.

Seems i explained problem in cover letter and didn't mention here.
Please refer here:
https://lore.kernel.org/linux-arm-msm/20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com/

Actual bug got reported in storage drivers after introducing runtime PM
in ice.

In UFS probe, setting UFSHCD_CAP_CRYPTO enables the crypto profile and
let blk-crypto layer send key programming calls(i.e
qcom_ice_program_key() in ice.c) even before UFS get ice handle (i.e
qcom_ice_enable).

OTOH, with no runtime PM in ice, clocks are remain voted after probe
too. When key program call comes from blk-crypto(qcom_ice_program_key),
it calls qcom_ice_writel(ice, 0x0, QCOM_ICE_REG_CRYPTOCFG(slot)); and
works fine as it's clocked register access.

With runtime PM in ice, clocks are voted off after probe and now same
sequence(ufs-probe -> key program call -> qcom_ice_enable) introduces
kernel panic as it's *unclocked* register access in ICE. That's why it's
important to enable ice instance in UFS before blk-crypto trigger any
key program call and hence moved qcom_ice_enable in probe.

Same sequence applies to MMC.

Though the issue reported once runtime PM in ICE got enabled, it's
actually persistent always and ideally UFS should not assume ice clock
cycle and get the instance early.

> 
>>  static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
>>  {
>> @@ -188,6 +190,12 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
>>  
>>  	host->ice = ice;
>>  
>> +	err = qcom_ice_enable(host->ice);
> 
> Use the 'ice' local variable.

Ack.

> 
>> @@ -636,12 +645,15 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>>  		 * is initialized.
>>  		 */
>>  		err = ufs_qcom_enable_lane_clks(host);
>> +		if (err)
>> +			return err;
>> +
>> +		err = ufs_qcom_ice_enable(host);
>>  		break;
>>  	case POST_CHANGE:
>>  		/* check if UFS PHY moved from DISABLED to HIBERN8 */
>>  		err = ufs_qcom_check_hibern8(hba);
>>  		ufs_qcom_enable_hw_clk_gating(hba);
>> -		ufs_qcom_ice_enable(host);
>>  		ufs_qcom_config_ice_allocator(host);
>>  		break;
> 
> Needs an explanation for why ufs_qcom_config_ice_allocator() and
> ufs_qcom_ice_enable() need to be called at different times.
I didn't get any issue if we enable ice in POST_CHANGE, I added as good
to have change so as to make ice available at earliest.
As no issue observed, I am planning to drop the change.

-- 
Regards
Kuldeep

