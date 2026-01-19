Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353434B40A
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820774; cv=none; b=adi5NxTg1PNCcHrSMMtxlrPkPoaI250zUlC0qCTRnnWcOEcEtTFIP7lsE5zwXKJL8pDydFgOK0Itex2aOKcr5d+50QVOrb6uTiNlZrK4uGUTWAxRKa48DFqsmUJK7JHV1m69PiNKYDJn1xXpGYTKh+5q4SVHdQjZD37/j6+NSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820774; c=relaxed/simple;
	bh=elY4oQIOKlfTb0ZU02BR1L+VR/a8AxqpbQpoBdamc38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+UInefZMHtgagAlteXAyZF9E2EpxGnNBhtJ1Tu2rfgI00iZY8E9bnWPPDiCdsGbLAyI0zBz6E2ZMlWFM1REUe7ubt5wmpEBaLKYw2QoQNMzEikcG1NYf3WHTdqLailPvh2s39L/EX/+WAgZAa04B6yKEee92wv9904FL1FBfXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mru5XJnv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T3CxkNjw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mru5XJnv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T3CxkNjw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J912ll903231
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 11:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pMmSR3h0zRY82QaIDVYb0RWT
	fU7J/2LftOD27trKy+M=; b=mru5XJnvZLIEsyvlZfN+zkT1AQlt74REJPOn9fUq
	YLDkKW5GfzAyYQMhUohul9IKvuH/HfT2z1l2OpAGch57jMCeVC+QoeYw3SL5wdrA
	uGr7SiuUgKlmEDx8ya9ut57iTmIFSNRK4M1WCu+c4xPUkJwbxjv4EIMv5hmLXi05
	HkfgTgk5an4M4HnobFUzPxfVme+dzAvWOf++scTju0Y/KjuPIN7xtzIf4Sw1vE0c
	4rl+5wF0L1TmWbsYTdcRd6ASbBKuKZcBKSSXW859gT/BrV954+NKQsZOHx4rKBqJ
	01+PMw7C60nDl5U3wgTZdMwMpS3DYUXzvUVRcwiK8Cv6rg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsb4yskdq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 11:06:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a241b5cdso603401385a.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 03:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768820772; x=1769425572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMmSR3h0zRY82QaIDVYb0RWTfU7J/2LftOD27trKy+M=;
        b=T3CxkNjwIMI3jF89+bQy3TPUBtRZw6xT6/cNEcCqCmpNy3DDNZztmBmxPwpkWmlxGo
         E+SEhCYFqv42aWPNyV/mrEBm6dKesK6K3xMhiEtieJXJe90lzBqZNxNzKuKpYYzeavEQ
         h8s0NW+1Adhn5JUc4dEPgr3+V0wt445OhZT5M4HOP+S7fHoNStzzHL5ZCUTQNJUx20Un
         S+ZinK7KLv4h5IKhbbHC78kg/nATWMNpjy99KFRC8Dj5t3Fl0GWqnvlPkK61+EfNlI/E
         6q8yayF0pqrM4l67nys+bfP9bk8wmNWsitcbsg0jcEP6NHVEK/4l9Hjmea2FX6COnVf9
         PyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820772; x=1769425572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMmSR3h0zRY82QaIDVYb0RWTfU7J/2LftOD27trKy+M=;
        b=p5s16AxT8ZgvJUHWfZjFFfE5BVkpfEZZgxAEUaHtGaZfYSQQFaX5v1eXVdnd/uOI5C
         ALQjMo72ZaN9do9vdM99eGXc4vOgzhbHmeI30YDhzP5pizJ2/nAjKO/sVfUjsnPhGc6e
         CSsjKz0zgyYHxW6sRTbj0B6lfduGuMD6P5c7UP5ogpXK9Zb9qklp4dI6duHZt44b10LH
         nEYWx1j0MaSgY8ofI6drI+p9gC0zQig/pcHsoCtDPHV5PzPAwL1aqCNiqznT3J/23HF1
         PKuGCYR7SkRLswC/UarLEuuk6Wib1Cy+imeWhCsWTGt0l4Zdv91zgvWGMJ5u7Jqmq2zZ
         32eg==
X-Forwarded-Encrypted: i=1; AJvYcCXKkc8xZJk1bZOQRFUC8X9bISEnn+dPAKW6Zs9zqxfbeQoFDUjWptvdt4UcSXIxDhTw+q3jMXhwQFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykv0ilpxrjZmNJdEwnETermF+P1Z8iY9LJNSZzxTjCO2iM21J5
	sf6Y9aed1RnRvWwg5ev/urhIO46ZSTIviWdW+bRLzWZmb4FN46A/iMtin/Ar6heu5amwi0IQ7P6
	+JuqhZeL0dnZOlJqmDiDHBcrlxeCAX4YKU6pLW892OIJN0I7Q2zVCWqMlYyL05so=
X-Gm-Gg: AY/fxX5p3ypiJlMFvbHcQuNeJHEYF3xBAY1bUGl5/TxUTpzeuhzCDUfLaTS7os6uzBn
	XHnAINDopMOmznQmxuFKnpYQSRGksG2sRyqeH0Te/0tqbRInj+YLhXaLrDiecpCX3whMJMPNa0V
	K/khzAay9Lbten1+FGjZGhKdXlSRdEyf7/ETEP71hwD0uqAims8yniRqtqabsvWC9gXGoov8ybG
	kOSX73bPe2lC8z6CRujzYqCvJFCAxf3IA5c+ij6QIRSsUFRODqHXGacNXr3l/j9cFReJpioPfn9
	q4jgjM1ICzz/ZJScWa8s27LFS29jCPczG/dcc/lFMif/Dmt2nZbqaIuseZW8KK73F8qoyyNTgsz
	epyv9AG5WY6mpxLe3jue7iuPR6zC/FzTH6VLcWpHAbz0drcQLGkyryYOm3g1n8cOkpmr+p1FMBN
	l++x/Ec/1E2t0H0VbQqM3ZKKQ=
X-Received: by 2002:a05:620a:2993:b0:89f:5057:974d with SMTP id af79cd13be357-8c6a66c825fmr1494232785a.10.1768820771499;
        Mon, 19 Jan 2026 03:06:11 -0800 (PST)
X-Received: by 2002:a05:620a:2993:b0:89f:5057:974d with SMTP id af79cd13be357-8c6a66c825fmr1494229685a.10.1768820771018;
        Mon, 19 Jan 2026 03:06:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf34d36dsm3184496e87.25.2026.01.19.03.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:06:10 -0800 (PST)
Date: Mon, 19 Jan 2026 13:06:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        ebiggers@kernel.org, abel.vesa@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-msm: Add support for wrapped keys
Message-ID: <yrvjt3eczzgqe2qukcqgxfpyw3te3a7v4gdvpx42hmlrxmacuz@lc4nsrybj7lu>
References: <20260102124018.3643243-1-neeraj.soni@oss.qualcomm.com>
 <3a93822a-6ca1-4cc1-be12-38b2b04704da@intel.com>
 <23c9f3b9-f575-5bc6-e7f0-46238c26a7e5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c9f3b9-f575-5bc6-e7f0-46238c26a7e5@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SNhPlevH c=1 sm=1 tr=0 ts=696e1024 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=34prnIKLCCa2sR58KicA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5MiBTYWx0ZWRfX75rshcw7JUPd
 WvrLVIMDJLGFfZVFVZi/vB7Vr5TxYk0V1WqqZ2l+norEimrUKGvyezdL3WGsqBpWm+/n2XCLlkz
 lac8TqnsR8EFoVuOcoO6qH6+ujR8vDE8RnBJYIrmcxeSVBw85rl/Oh+10wjVeScI+SR5qN+LH+F
 GRfEihBmin3bIeh/EpyoWcy0uo4Kqa1Ue+FtOypoY0ETCAVcYvTkAKKGWopkBPoIrrLxVPdTemh
 Wl6V2jiJq78w3c/Yn9lbwYKokDOPTPWeoHNh78swquutUNt9ynizIWIhIeYz+kqA4ych7qMuCyQ
 mQCpaJzYWeEvAFQmDqMhXaf0DKtGolgd/TClHJ4EHTXj807POpM1TSKyU01JmjtH3MOgKLtUTq2
 ihU4uvRqfhZZYpggbzGdVhoM20Kb5575EFFzA9eV0VJ+j11TPTc1jlWpMYu3Cm0D306Oang3mSb
 Tv6gZAHaXqx25dJzi2Q==
X-Proofpoint-ORIG-GUID: hAZbjfvQVo9uDEcWZxpggJa7ppVLWozE
X-Proofpoint-GUID: hAZbjfvQVo9uDEcWZxpggJa7ppVLWozE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190092

On Mon, Jan 19, 2026 at 03:49:19PM +0530, Neeraj Soni wrote:
> Hi,
> 
> On 1/12/2026 12:35 PM, Adrian Hunter wrote:
> > On 02/01/2026 14:40, Neeraj Soni wrote:
> >> Add the wrapped key support for sdhci-msm by implementing the needed
> >> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
> >> blk_crypto_profile::key_types_supported.
> >>
> >> Tested on SC7280 eMMC variant.
> >>
> >> How to test:
> >>
> >> Use the "v1.3.0" tag from https://github.com/google/fscryptctl and build
> >> fscryptctl that supports generating wrapped keys.
> >>
> >> Enable the following config options:
> >> CONFIG_BLK_INLINE_ENCRYPTION=y
> >> CONFIG_QCOM_INLINE_CRYPTO_ENGINE=y
> >> CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
> >> CONFIG_MMC_CRYPTO=y
> >>
> >> Enable "qcom_ice.use_wrapped_keys" via kernel command line.
> >>
> >> $ mkfs.ext4 -F -O encrypt,stable_inodes /dev/disk/by-partlabel/vm-data
> >> $ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
> >> $ fscryptctl generate_hw_wrapped_key /dev/disk/by-partlabel/vm-data > /mnt/key.longterm
> >> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
> >> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
> >> $ rm -rf /mnt/dir
> >> $ mkdir /mnt/dir
> >> $ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
> >> $ dmesg > /mnt/dir/test.txt
> >> $ sync
> >>
> >> Reboot the board
> >>
> >> $ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
> >> $ ls /mnt/dir # File should be encrypted
> >> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
> >> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
> >> $ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
> >> $ cat /mnt/dir/test.txt # File should now be decrypted
> >>
> >> Tested-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
> >> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> > 
> > Doesn't apply cleanly to mmc next.  Otherwise:
> > 
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > 
> Is this a blocker for the patch to get merged? I will anyway see why it is not applying cleanly on mmc next
> but wanted to know if this is necessary to resolve for these chagnes to get merged in Linux-next?

Please read the internal documentation on the patch flow. The patches
are not merged into linux-next. They are picked up by maintainers (e.g.
Ulf) into their trees (e.g. mmc).


-- 
With best wishes
Dmitry
