Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B549CF27
	for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343551; cv=pass; b=Yz0bw42A5UozsWa78EJZLRgvRS++u9Uijx3m0mLxcEzYeQCJL7Mrh5wrfbmT0/NpXuHZG1GYQqavyFDjc3l0qxzKjCClMvYxSg3e5tzc+Vnt2s1TjdSW+9Sb7W3tnTezHrnlpEjNIL7h0yfv0MKblsgYcCzq6JkQCrHiLeoB3HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343551; c=relaxed/simple;
	bh=kqdNlwg778/987rRPFcemtjB5R0/alDQShoyszIUXi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZxoQFvZFFEa6hgQDmI51SHQhkVyt9ONzRjqH9FMAehvJsKl9YQiLJMQZOkEKdOytO7gfTlDtUPNLH72dRal5sxn54XzxERxAwJrQT8YTQM8pJJkEbi3Hdvla7lu4H8Y0sfav1lTz9THGj80ArHSnopINKSbIReLPvOVL3X3UAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CiFirrNM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjLnN41T; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CiFirrNM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjLnN41T"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PD3upe208416
	for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 13:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=; b=CiFirrNMJE46vkez
	ab/ALVoKzVYq3KdM+wurlRbp1B6pozl0+xZlajKqHYhciUozzuBY7HlW4B9bEgeq
	01aTayxTFbLZjXcK2kUyA4C5CGDxayVgrjT12DPiulgqZp8+24MXVbQFUBKalGN5
	p9GwIgBIhMFeCrnL/r+4yFxTmyyyZcUvwHKtmgVueHEfPC1dTHXv2IcCvaA5pY9E
	bXsatblJpbCU9xw3/A1vAwABdtqMVYDxHNRpOtBokCQv+9P5D3KSurkRHYF8jsvl
	7RxWADkv+Ho9B8J+D3C4m7HNizpmI3Gz6NL7dRH63YIWrYea4jFZFF+zLX2j8bQ9
	XChfMQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898uph1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 13:39:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530d206e2b4so19391851cf.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 06:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790343548; cv=none;
        d=google.com; s=arc-20260327;
        b=WV8IOlpq2b8vhgeAYZ0E4A7E/RrpDIRMYGnX2SIQP1JjVLyb0jbY1RJnQ5eUzZuDDG
         hk1LY6FwPJN5NobR/8sUC1t3Yi9rr4YQPZZGByhRO/HFbWUcxBjzXenmUMPec2WA5GgA
         dyMsQT5m/DrUdx1FBIzy30lY6kXJWJVRSErCPaWOcHzanuRtOZGXT3trGNX8Yy3RJzat
         jN4q72PwpPvdZo5k9axEalM3mEkPZJCOIjJCjCTiFm7r9Psey0598Qap2z+R/gFATVy/
         4I9g6K1InFyZwKW9iNsnj9WE4B2iMjCcJjRi0sjvh9/6j84Pvm1V8zs2SI2Y00uXN8dD
         ZLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        fh=XSMO0vOozTZ60T0Zm+FAqW/VkBNwxVztBt/apwH7gM0=;
        b=nQZjlio9Nlwm16/ghylQcw/je15JMcD9LoEVKzzs/LfV9NYxrK+FHM0eoqkbc/UD1J
         6kp3R7YX04fWrEZExpfDugSCWDTqIBKsNlkr73+JmMfC3jLq06bsAGAguhEZfncF0anO
         H4t3Ryf6qiwlFAcA2y5VwPUvwsyHtDdVQ2/fc5TOQ2GhLI5R8rJ5QupeIN/oGoJArcal
         XQLAAAx/0zufoidGNH/kEd+bC45QNzS2R6K2mcsGZG3oqOUzA6NeXdY5FBP3IE4iOaIt
         fYw4ckQwYQPMmNUjT5e9kt/3BhmqAWJ5dnMsQwAy0OjVHJKUm+wrTnF37tKOxVI7KdPS
         n/zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790343548; x=1790948348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        b=OjLnN41TvHXUGa7MBrf9fj+CrpaWlDp6jgP20kUZ79RYwBnqHsD2K/ZHsBfxJr0C6X
         5bLg4kK6XWXCGlWpS4+g8GmhWc5sivFMkZ6UPcPR0PfTiZKGAXGfrZJAn1JrUrO9v3pL
         +o/3NTphHMc1pEr1w9tuiniwaSWa84DJXKLHsZJBOqqauXJKVeciIGSFjrUGEe+xevFE
         0tu5GV/o/wBP/LDnwxL4ckGIva0g4Fy9erhgynszry1UC2kIN6hUmqZne6dnMQMW7GsT
         RLoI9Iw1mSzZIhFcCnl5EDBJRUTgLvqYhyFIIEVyfYO8DPzOfGwQ8Vznq6kgHkRZsrq9
         XTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343548; x=1790948348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        b=uLrN/pxiap99tzi7ln+J1N9j4/+dQ2cvKMd6zyg1XjP5VvM4S9Ix2AZPh8tGdGZFUb
         xYmxrYUr4GloIWbASmZhUy0oRBVzmJM7DXnJI1Lqs8rtev4DaAFmnP6OCfS4wbeyPO9F
         zFF14tApZjXASHgV6ZVMVv1J3OqsVy7MXpCl+/NoxNC26HX+JuQDY2qU+Ni7QX9R55fC
         lF79rcmDL0v0Wg2FNh/t04s2NLj3Z2kD8zRJG67oOfNliJc7lFoLlvWynXSFq2PEmCqn
         bhJNTLaySkJDtif/faB8AjHHWfgp21O7Au5gsHAFI4P/6B0+hIbd7Bb2M3vAA1aOC3NZ
         0Ljw==
X-Forwarded-Encrypted: i=1; AKwUvBytHEnmGnmwpeWS7cgHFtPgQZW7jQpTSlWVrBd1vhQwn4G2IvK0mSrfgnQtrOqwqIWt3ey2Mxh9tcM=@vger.kernel.org
X-Gm-Message-State: AFuF++nbJY3yOWoan3ZrdxB6VTCXmCCvosnWEJ4jDUWWtRmPrKiv4LXe
	fIGBRFJtR6fsuz+2Ixk2tqIuWpapfN613fC1r9VRV2/A2Zv/kfBtQ7NaPFcxziZtexYoTp7gYb8
	NvkoaVPKn7T2G4lLUjxTNvcs/cFxoPZ1DY68XQ7mVQ8cdLK26MtM/Eo8M85SPa9HlaZb5PuoD0y
	Y2HFog8Ky/LnfS13Ada83VkLwJbEcsg5gsmtBHPA==
X-Gm-Gg: AYBFou3WeRRUqGzWYNIAohrd6qa/A7jmFboXNNtDJea11gSdLaG6xU9KXMhrM9AqANW
	ALJNXtITwseSP7sT4hmMPE/dhl3Eim3JWlDZK6RvBrwzBaOxcPw0RvOeO8OsatOY0Wy+e/BeDKD
	JIZiQkSDiffcxSDipcK2ukREQZUjdWrz8FbzDdF8xfhMwlm3+Fa4PsSvXxnhmiw63XGUQqliodV
	cX/+JIzt/mkuteFFdeKxfvkvPdkiLUXs8nfiMmb/eKV+JXjSWANnGijtpbxwkSBiROcIHuOwFA=
X-Received: by 2002:a05:620a:4588:b0:93b:fbf0:8791 with SMTP id af79cd13be357-93c43bf1ff2mr431890285a.29.1790343547642;
        Fri, 25 Sep 2026 06:39:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4588:b0:93b:fbf0:8791 with SMTP id
 af79cd13be357-93c43bf1ff2mr431882585a.29.1790343547133; Fri, 25 Sep 2026
 06:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com> <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
In-Reply-To: <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:38:56 +0200
X-Gm-Features: AclHuK99T0Ubawi22EyQadvbidnQEmVlySi-fMkWCvta4a9Udx0OX1G_I0L1lvQ
Message-ID: <CAFEp6-2P14MdYJGuH6ygRL4ZKtLnJEj=PVMx2p+b9L1RuiX1dg@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM providers
To: Jens Axboe <axboe@kernel.dk>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX6AzlQ1+Z5pbh
 kXD0pFxYOpf/O9FpR9ScXbf/ypWXiPLkCm9+f0q/CfKOgrI7QmE1xzzwWwaKR30ZYVBUsoJQWgL
 Kk2WRvaT1fuP4KApyOCSF8bIvKi4iPKOLRK1nuHHfA2jPSE2Lralk4iVoGaMVc/6UqEXkP1xJCk
 GhF0U+zj1Mr5EJTwvAH7cWDQI8MmzCkT6FNtLLB7IiagqpmDszDmP1JiR99UcTj/jW/59L9pHV4
 8ZUhU/QFx2zW+3LHziHC7z8FX4V4nEM9lI1AAox9ePbGj2I3a15l1F252qyMqPUsydj9mn4m/lV
 1aHOoljyL16t1WOE9aiUMJwg7pQFqVkm5uqW6hDTRp8rFG0FKHyyhMy9hMYgAU6tkK6YQlbXjEj
 +TYSMlMo6JBdz98773fcoVkdtteUN2mP3yQTKeLw3dHU3TivyeiPU3DhB/lheOR6sKxCN7IUsDw
 1FncatQkB21OOVfiBMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX6Qw2js/XH87q
 filx4X8ciGkSHX61TWogwfgsfN4V5bpYUmBzCV6ATKX2P+e8QAmQX3OPQMSh0EvaaJIgpzVuroN
 cuqUfE7DEBX09x5eIlJ/RabEjUHOd5E=
X-Proofpoint-GUID: NkxRHVxpE1QX1YmvQvqLstTNxxW9vwqb
X-Proofpoint-ORIG-GUID: NkxRHVxpE1QX1YmvQvqLstTNxxW9vwqb
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab6797c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=MW6_J8xfeE2cRKj6bkYA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250054

Hi Jens, Luiz,

On Mon, Sep 21, 2026 at 11:27=E2=80=AFAM Srinivas Kandagatla <srini@kernel.=
org> wrote:
>
>
> On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> > On embedded devices, it is common for factory provisioning to store
> > device-specific information, such as Ethernet or WiFi MAC addresses,
> > in a dedicated area of an eMMC partition. This avoids the need for
> > and additional EEPROM/OTP and leverages the persistence of eMMC.
> >
> > One example is the Arduino UNO-Q, where the WiFi MAC address and the
> > Bluetooth Device address are stored in the eMMC Boot1 partition.
> >
> > [...]
>
> Applied, thanks!
>
> [04/10] nvmem: layouts: Support fixed-layout as the nvmem device node its=
elf
>         commit: 9c6cab93dcd47c3075d896c777567b9d8f813d18

If you're happy with the current state, would you mind picking up the
block-related and Bluetooth-related patches in the respective trees?
They are independent.

Thanks,
Loic
