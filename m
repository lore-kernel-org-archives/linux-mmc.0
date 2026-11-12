Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477584;
	b=kX8s3ztP5zqe0WZ3eBRY1VkU4y+c21GXqAxgrvxfUSd9f4MRbCdZa1YfF3bRnfTU8OVb
	 IEIIZRKjrG8gRMN/nFloVYBeW2ZT/qZsC/Ri31LvfC9Hov658y7TrtG+I+4PU+6N/Pf2V
	 HGpDOHoXltrxQ1p9dXBBGQ6xJHGxYCyGX8TvP6m0GVQF1zRCvODHXmBd6BNQnl3TY5htj
	 NjAab8wjgaCX2KH0Gdg3duE1zSr1IDPjMZHYXVh5RpsTDUvL19LJwTFx5ZMJASpi1ML9l
	 rnYCW4c4t7Fgsf8WFSIOfj2FmrIQQ3qZhgQDIa4VHpCCv/kxFtYvx2w36QuRwi8Cfsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477584;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kdVV3SEHauOLt7HICNv2pGDFaIdsDo3i9Ev2IzLm2Nk=;
	b=lx+86xXRNV+h0dKWM1x9Yy/3YHNfH3L7hG/u3RwwMaTBurQkS1ounJZjKBYvElJufC7B
	 XoFw+H6TBToPdoiB/+J8D5OIfrpan/GZi5gtxR+frCDE1uqj4oENMJ8qxZrl+9TGKTHwS
	 P5LYP4wfXn9V9WU0eMsKj35OiIQUXGdejh8OlFuY9UAIog3wUaHo/2rcIeKuR6iRj2WPw
	 Lia2KNUHqcD+uYNCRWkHLNn21ayfQBOgeG8WvhCV1McKeXW7Mze0Y30fbVOD3Zeio8b9C
	 i+gVdF3Re6+ehHS3PQsbDkoWEIype5FtHVzB6HeIhziP+e67ed4gsWbxTsyvA9SsO9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dAIhFCtJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XoBk5PYo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E050606A31C
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 09:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E050606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dAIhFCtJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XoBk5PYo
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC53tUE3477246
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 09:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kdVV3SEHauOLt7HICNv2pGDFaIdsDo3i9Ev2IzLm2Nk=; b=dAIhFCtJgHYjNdcC
	Ngrlb8LeVtNnGrjeoojy2CEW+j2OWWFVLHPBqPQETk34ZR5r9gTN8qu5K7B8KF2y
	UiHvTlF/8EXJMiuF7qOoiogL6XoAsxzgI2HdMeXnEj3/VfWvVS3vKjH5npuWo9oC
	y3TbrsHGErIXdn/HACpbN8ppxtKB0LiBMPLSaNFfGxpIo/rpCkCS4dUV21ZyoGsW
	AIxUhv1sK13Kz2aZQNalvuVjjbQATKc9XQ6U2D6hN8CHotgvVXwIA1kfo7abfSf7
	N9ByrZTCJLj0mA1Na/+jbkEZxaC0dEiShwl2dqsBFH3pxo58QtHBA2YESKmqSaHl
	x3xztQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yuh0xq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 09:59:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f62934ef6so930914785a.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 01:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794477582; x=1795082382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kdVV3SEHauOLt7HICNv2pGDFaIdsDo3i9Ev2IzLm2Nk=;
        b=XoBk5PYoNAW4S9zN7TeaCw03wztz/X0wkyfYGSleV1yEmphQgcLwUAywI6OufHCsvm
         s+S3lyRu0WN7HmsfZWCxeGJHhr4i3kJBYXyvvY9nShI5XBsHwogQ1YsbZJQS7f6wbSyE
         pgLjsgXeP2qnIk5jUiXpZLckixHus8Pzmvz6+7ymZi+oH5U94If7xok+MW6nGyWk/FBq
         vNqgrmfhVakZndaD6KgWpOvWSPYtoCwsZYcjIUSmiQAB/z6hAyjMMbMKdJl5geOkVKoi
         6yRAQhy66jIlRAl79zHipZw/PAystCu4BDriM+UoRMs7GnswAaDHpTWkoPlj/LeSLsmj
         HmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477582; x=1795082382;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kdVV3SEHauOLt7HICNv2pGDFaIdsDo3i9Ev2IzLm2Nk=;
        b=e8lsrN27PefmdKpuPR+H92OfvzgL6xNPqqk+FVLNg11PFAd0aNn5IkoqDFCyrACDZg
         mvcN9yh19KgxWurNXuzvH1N9vpbFqWOr2v37kBe9yCqntUSPwxBRq24G7tv7r/SvFAin
         vT1ocEBvcTm1sPbqfce6UpXIoobnu2h3K2hn1LweufglB4405GYL5OnGif+Uhg9wFnye
         K7sVGWl8BWxsqSq3wTGn4BVv+XDucFf8AZuKT3ysTbD9vp87hfS8KpzrJFuVBc5B/ZyX
         f0bcYEu6+z5jGzQqtOo52bB+1iO90iWom9C1zOPyUeDq0Yq2CqOQFQk1yApStccEdylZ
         kQZw==
X-Forwarded-Encrypted: i=1; AL+hErE3joQrYty4X9LaHphn7Q0zhFViGwRkZbwCj9h+O2qsnUQjDy5fPdFNTb6fvo0XJl7gL//GnXN9Pr0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EhM0TSPzKyhxAnPU0kjT7+hc+pOX8CNbp7btyhUvUWnNWTv2Z
	ZNCGFrPKRn8JUxVaFvLBFR84U4I5KhJvz10yvi/sqZRmFG+cL8RT6Wg9sNcIC+wRgl5hUfTt1vQ
	/jxKiLI1svoqEf2JtHDQZjSVv43C9zPUEKxjslUut4GsRqoaX3Qa1xx7/jtlWu7E=
X-Gm-Gg: AYBFou2lQIyVQyDoWnrYz6MfIi/DN4q8VYL/Z4Ut5YHYf53dUveLq1ItDQUCUq3soE8
	lnNUQHDu5ngBrfEV02qgArG4bfwK+QjqEdcDp3CMFJiOZJpcPT8AukfzE7laFven0Q1I2MfCq8n
	ItdlXZw82VHUegk6BfygZg4vfRFO9Vmh9gDTZpkPNxnndb5UgqeS0uAV737ITlEaLu92v9VPDMb
	E80Vt3Uj745M+PIhNpTOXa0VYI8tBE3UcYdX4N1Y4qkgWgEiO7pCOlAh4X1AVSPRY2HaIj2b9+P
	0iO+dKkcda+oa8BA2MmCeTq7Y5L/YgASO2fkLyn4bSlXbfacPteiF25nFR9O1otMFbBurg0TheD
	T+StgIQNDPxTuXW0YeIDccic9r5vVu0eLK3d0pphAiBuxr9vCdBJbaTa99Sl8bq2T5Ic1kzPafC
	WLFd4U05lcOFlNE9Vh2JwMMD/B/nmG49reT3qywNeP3ERpYG3QTnT7aWquKGtfbSlWx7lbMi9ZO
	6PCDLb5UUC6v3sKY3VrrukGfUA65THxjTcIr5NP1pE=
X-Received: by 2002:a05:620a:26a0:b0:945:f0ca:436a with SMTP id af79cd13be357-947afcd6319mr845701685a.2.1794477582323;
        Thu, 12 Nov 2026 01:59:42 -0800 (PST)
X-Received: by 2002:a05:620a:26a0:b0:945:f0ca:436a with SMTP id af79cd13be357-947afcd6319mr845700085a.2.1794477581916;
        Thu, 12 Nov 2026 01:59:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a649875sm317803466b.64.2026.11.12.01.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:59:41 -0800 (PST)
Message-ID: <2f680bf3-8c68-4dc6-b457-ce381cc4ee88@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 10:59:40 +0100
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
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag
 on sdio_func companion
To: Luka Gejak <luka.gejak@linux.dev>, Ulf Hansson <ulfh@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20261017160448.77436-1-johannes.goede@oss.qualcomm.com>
 <8ac7b295da3af2836e88faeb2b464f6ca80932d1@linux.dev>
Content-Language: en-US, nl
In-Reply-To: <8ac7b295da3af2836e88faeb2b464f6ca80932d1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4eTm7fwgKV9w0wB19YyCId--7Xro0nYZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzOSBTYWx0ZWRfXyejNJsL68aOK
 qu4Z2OXM8u9xRxtGzm0rHsiAyDVZmZ4WZOpy7+qnKcUrPJKf9SryzZCuRHx4qtFnMysuxdrV3or
 7W/EnxzuJz6qWkAaMkqM8XX3FuAY//A=
X-Proofpoint-ORIG-GUID: 4eTm7fwgKV9w0wB19YyCId--7Xro0nYZ
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af58e0f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=Gfae7-l09DI4fA1CBzkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzOSBTYWx0ZWRfXwOdlCtT9Pdeq
 qZdFPRTCpcQmlheQes3+gXJUNhDt7zga2bdJRMFAVVO6dJS4fk5QV94t9/6WlUlqvnTNjYPNe4I
 UFOjy3AVFhYMJiZSQ0nl5bre1e6KXCwj1v61ClZNM/sTEQormNHAiBSqFI17AD9smscSq8fF3Zq
 oJN30pj3dGSOGFjFW7XsHmT/ivyID1EUILoy2dK3q7cvkOiDveR030xzX0hOJBHLDsXfhbUtsPo
 psq2bb8eD83CcfnPKUWYitojZwCnvJNYk3TrhlSh+UvTHukJSkGKJacQPxChCoqik1g9D1D1uIa
 +uLH4ty7olDIlN7NSDlFFSPPj19ejITrm1CyhI0y7ni9oQmC28+QlTPHfXziLi99b2N+lHjHppc
 6LD+bv39PVPRL6U3RoZugUqLgJmVZ9NL1VGQUMQmqnFv2gg/UjJNfzjpKM/8RTEkmXjY+D6lLrK
 b/bfv0EKM7YOlxuKx/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120039

Hi Luka,

On 18-Oct-26 14:00, Luka Gejak wrote:
> Hi Hans,
> 
> October 17, 2026 at 6:04 PM, "Hans de Goede" <johannes.goede@oss.qualcomm.com> wrote:
> 
>>
>> Many MMC host drivers call pm_suspend_ignore_children() which allows
>> to keep MMC cards and SDIO-functions on while the host is suspended.
>>
>> For SDIO functions which are in the ACPI power-domain this causes a race
>> where the host may end up runtime-suspended before the driver for a SDIO
>> function loads and probes it. When the probe() looses this race this causes
>> the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-domain
>> code with e.g. the following error:
>>
>>  ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot
>>
>> Busses using pm_suspend_ignore_children() for their children should set
>> acpi_device.power.flags.ignore_parent on the ACPI companion device of
>> their children to avoid this.
>>
>> This is safe todo because drivers for sdio_func devices should always
>> call sdio_claim_host() before doing any IO and that runtime-resumes
>> the host.
>>
>> Add the missing setting of the acpi_device.power.flags.ignore_parent flag
>> to fix probing of SDIO functions sometimes failing on ACPI systems with
>> the error mentioned above.
>>
>> Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
>> companion device wills stay around after removing the sdio_func device. To
>> make sdio_acpi_clear_handle() the proper inverse of sdio_acpi_set_handle()
>> also make it actually clear the companion pointer on the sdio_func device.
>> Technically this clearing is not really necessary since the sdio_func
>> device will go away shortly afterwards anyways.
>>
>> Closes: https://github.com/MocLG/rtw/issues/2/
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
> [...]
> +
>> +static void sdio_acpi_clear_handle(struct sdio_func *func)
>> +{
>> +     struct acpi_device *adev;
>> +
>> +     adev = ACPI_COMPANION(&func->dev);
>> +     if (adev) {
>> +             adev->power.flags.ignore_parent = false;
>> +             ACPI_COMPANION_SET(&func->dev, NULL);
>> +     }
>>  }
>>  #else
>>  static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
>> +static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
>>  #endif
>>
>>  static void sdio_set_of_node(struct sdio_func *func)
> [...]
>> @@ -414,6 +432,8 @@ int sdio_add_func(struct sdio_func *func)
>>   */
>>  void sdio_remove_func(struct sdio_func *func)
>>  {
>> +     sdio_acpi_clear_handle(func);
>> +
>>       if (sdio_func_present(func))
>>               device_del(&func->dev);
>>
> 
> I am not an expert on this topic, but clearing the companion here
> before device_del(), looks wrong to me. As far as I understand
> device_add() binds this device with acpi_bind_one() and that takes
> a reference on both the companion and the device. The unbinding is
> done in device_del() via acpi_device_notify_remove(), which returns
> early when the companion is NULL, so does acpi_unbind_one()
> never run and the physical_node entry, the sysfs links and the
> references from acpi_bind_one() all stay behind

You're right, thank you for catching this. I'll prepare a v2
addressing this.

<snip>

> Would it be enough to only clear ignore_parent in sdio_acpi_clear_handle()
> and let device_del() clear the companion?

Probably, I'll dive into the acpi_device_notify_remove() path
a bit and make sure I'll get this right for v2.

Regards,

Hans


