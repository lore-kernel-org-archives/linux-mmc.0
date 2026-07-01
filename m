Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3461423A87
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902453; cv=none; b=pugJFf2LOyUChVLaN+Rde1CQlgyUWGZn9giHzKOwvsgH4I7hgmr91TJiuGykIBsuOKtNuFYMZbyh6MVx7rWF4I3AKb1cSYDGZrcCKj7OSxMugKFBYIElS3xD3D1Rxig/BoNASIPZ+3+6ZIGlRnkFXT8O2X4v4FqKp6cWQkJFRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902453; c=relaxed/simple;
	bh=HOn0CaCePfNgAAG9q0s3jJIiPvvFTH5KrOgQqhOkSqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d02GlFfgCDR8pPlqAN3C7GAuEr2YpwYTNLaqJUsTNVSyAHrImyV5N7Eo4mX31Ay022lsIlU/BTZfDNGfVoc2pZebH6yZAW9p2eiCHlH2rnk+gL9AuPL899KPyvkV+h0hmYbI2Lxg9SZCwnTVqDuZtd4F3DgknELZad85UXx+vHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nsg+7PGS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GyL4FosQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nsg+7PGS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GyL4FosQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AGXiE794114
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 10:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=; b=nsg+7PGSN9LMaaHb
	vP7qwVAt0LvmfNhpwCNGGrHCO3fVvstLF7mT3Di+sWTZork4SslT9bHt26h9Mi92
	IaYhXfMfqJWclBMkqxErZVX/sXvQ1vvohbsCRngPa0TuPp5VB+JOzvndmxfZnSkJ
	ieUI1piKVL7WKls80+Aju0hIxcycUnroOorlyO/9M8hEMVrMg9Pyrww7Lxd0qWPN
	ZqzULmqFpA7/z9kemgHxgGkpVUbrJUSJzUqeFMWkqUtdHdrWDrwwRvgol4kD4Mps
	FMcvtl/2AdFVVCEzWSJDZwHSG2iEjIVD+UGCQ4/eUewg5ouFQT6h713Po8G7SAkB
	+O7xfA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510ag3wu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 10:40:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c267931ebso1500401cf.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782902448; x=1783507248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=;
        b=GyL4FosQWSFeMIENYzn5k8JSIEfI2ZrGYNpC1fKjjmS6BTMlrw4rxicSfTG4qjXnIS
         9+CZ3gwlOkhoeRZcwnQ0b6/iEy4VFcwtGAfWMcCC6SddQdXl7UZc862VOOwZn/5Y34Mw
         FA59JJ+0GbiFvCry5GBqdGRKHBNyXTjoCEPdFTN7jrt7Tp1GF/CsiBad/vFQWNmP2Q8U
         +6JzkSpZsT3BOUv9RqiZzOYkPZcdR0S+7Odk37PqsVEGPqI1rCzZfz6VT5Don0LtgZen
         rSOTEplzWuWhvChXWd4lm9B0fx0lROoKOZLkV5qzDxDiADLi6Fy0zCPvHzltp3aRKxnt
         rscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782902448; x=1783507248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=;
        b=DQwKpdwXklkwHbngRjEHPayELNNlha/uku/dd5/C7RtR5qWj6q5CI38tw71bpb8DFG
         m2OsosgriwfhGcBtk61EFY9rHBVtbkk2PHqbl+1pLQVsFG+wh87Jj4km9+4urvOf+MW/
         Aw5K7PjughmMoIfytXJLO6C8DzfZ8SIYLURDrtbx1PwuN6XtyYCdvbXh5O27QYkbWKdk
         6YmgyNyOJpXYKmIfPBe5vDWqTRUmFJCZY9j9QGFrmUuMIUIuBUTy5QiAmjSg1zm4qhe4
         nA6tCzlkGTYotB3MVmV5v60rX2RGrbg6UGBsdnrIwFyX0++FtGXq6Se9NxybgnQPj6/M
         7xCw==
X-Forwarded-Encrypted: i=1; AFNElJ/1MYwVdLUu/4v970F+KtDQnuJ0I80nY1xfZWwiA284o6XL4f9DqCP474HC8mrJjLgEzbE+fPQbqns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbx6y7tRnFYqjKAKP5iXRoiCk5yK4S1Wr6Kcv/lLUICwSqOhf
	YapbFy7jt0zOxJqEVl6K/ymF9F+GD0NEntipJS7eqiwchsiehtGaP4aXG2ZrMSS5yED6+OccJ24
	j0MOFnjEE5YcwsDkpUrYZBOX5+T/cJ/JdUrsm+fRcZfVr5lNMJx6WwNVfpVT0yAw=
X-Gm-Gg: AfdE7cmJSgKZNEmQmG78Dk1yk3k+GkuyYFD0Ir+iw9vkgYnSPpzS/KP+veTXNkzDBQt
	UXXuKEOmMdDiMwNtx70loQaAUdz+82elKjIlMcW940+HhOqpSdJ79RCi/mIyO4oyRh7JVubQE1H
	SQ0zKRNSOWvTi+wh116UMdwOYnqwCg55APBJb2BclrRyIVbqPonSHqZ2Ib5Jnr8bgeT8l4mEELW
	Y1ke6ZdMM0eJC9X/8g5orygbV6h6QBGSyU0S9+R/Zpm+LmhKI8nr/iIuk2xs7+XA60l5lcxPgez
	g4s1KQ2V40AfuVFDtwnOrhygmfoEbaqqmA6wY9C+x7dkGYuwx5GjoYw1owATB297QGn31ve1tXj
	az/jmbybZ8+wFyTzEZRe/tdOVTbgPPFAK4ZE=
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr7031871cf.9.1782902448048;
        Wed, 01 Jul 2026 03:40:48 -0700 (PDT)
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr7031251cf.9.1782902447419;
        Wed, 01 Jul 2026 03:40:47 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1296b1f9cesm165809466b.16.2026.07.01.03.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 03:40:45 -0700 (PDT)
Message-ID: <175f7835-df18-4bc6-8267-ceef35696af8@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 12:40:42 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
To: george.moussalem@outlook.com, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wH4cc72aoJCSYUoP1uKeeXJt2ac6JlYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX7AFiQLNasqSr
 klE61pCUeT1OpKG7HWqtoebEk8Lj2+uqD/0IXHe+vkHMjE0u2Iz6IMtw57XsCeV37EuBEL89GWz
 nAaBl5t2SPZbvBJxhx0yH7xIhNXEhZlz+7z/40fPmB0YO7kIDbXvD7Phehk/67klB4LZ1V3WAox
 6ABBhxMQdtKibMqGrNmS/8Spi6zydm926t7zNeianQu9n+JDxS8AJoJokDwFRtUEV2r+j3pR/Pg
 ymwLRUaQHkglUX6XyL00ffNuk67SKuzdZqRJ8diwLz/MPtrPSP1c+LEZxEs3CFfNhi9JUcRSLbP
 lLP3laoHqd+oW5TCqUlcdeT/+PSGjI/XfOpEaV40RcHaSmjqXiS1ROQ5a/yJYqvxMq3yz1R3yTu
 VoRSEfu9RnBqIZyscYp9MfJOVMzht5saH4j8YRYzE5vr9zghyYLUAN0Gg6acoxMJnWwUcFzaNVO
 HkNnaB8JthTuYvJDLDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX5HZ/eQ4flvam
 1O448K8shCAJZrHD9c7Xi2g1StBT5bW2q2N8ksawjU707xkjgXJr+QcpXuAYNSoRXaW+pGvvmdl
 f1P1NNjyDASFkIPVhgvDHs80HxDirpA=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a44eeb1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=UqCG9HQmAAAA:8 a=506_Lbxh6H-Y4vAdgPkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: wH4cc72aoJCSYUoP1uKeeXJt2ac6JlYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010111

On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
> modes which are required to be configured through a Secure Channel
> Manager (SCM) call to TrustZone. However, not all Trusted Execution
> Environment (QSEE) images support this call, so first check if the call
> is available.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

I'm amazed changing this setting is a secure operation

[...]

> +/**
> + * qcom_scm_pas_set_bluetooth_power_mode() - Configure power optimization mode
> + *					     for the Bluetooth subsystem (BTSS)
> + * @pas_id:	peripheral authentication service id
> + * @val:	0x0 for normal operation, 0x4 for ECO mode

If there's just two values, maybe we should make this take a `bool eco_mode`?

> + *
> + * Return: 0 on success, negative errno on failure.
> + * Returns -EOPNOTSUPP if the firmware configuration call is unavailable.
> + */
> +int qcom_scm_pas_set_bluetooth_power_mode(u32 pas_id, u32 val)
> +{
> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
> +					  QCOM_SCM_PIL_PAS_BT_PWR_MODE))
> +		return -EOPNOTSUPP;
> +
> +	return __qcom_scm_pas_set_bluetooth_power_mode(pas_id, val);

Let's just inline the whole definition here - it's single-use anyway

Konrad
