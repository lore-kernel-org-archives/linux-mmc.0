Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49D4657FB
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850994; cv=pass; b=aDyZu8Lh9JYOatsgAiw/TBYkpRgfZRWy8CSTj1v21J+lFpML3hIEZcjk7xWdjyuLrl+RfhWNg3mUti/QXDbNHRTK0E5n3njRN6bhsuHN9ocw98IQlbnulFjd45gAwOOqfpI8eUlZ5cYh9A1nKAqobtnKcUC1bM1TroD//ppeTWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850994; c=relaxed/simple;
	bh=Av355PoOiQqfN+lI28kxuagN2wHx9snA+0ylF3eg6GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XE+goeRcToxaAhZqn6prTa0EUdo4l5ERROuOJmh8Sp5ah7FbRUYRjPk2/2SCP2b1OlXuJ5+l9gc0lVTLhgOfhW01McmbsxEPENkN9MG9hUrGAt/miN8x4iyeXBglpfmsxhjRPRy6sAxI63tBwSTrezmemBW/DktNKnWsO0FTvcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gWSqX4An; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MZQslKWR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gWSqX4An";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MZQslKWR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CXO6D185698
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 13:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QWQr/x5bEL6Unr8s/2mTIOitfI4p3mr1jrf6Pl+pGJk=; b=gWSqX4AnlEtpxj6Q
	Kolx19zNihtI79jb/u5x93/3RIRF/ynzmhH52E2pAWDlIG40klO9F3WYrDnNecrA
	Mvfb6nxJuTNXh4JIR0ajkI+lba7CtsfsM09qOuD/mdptyX0Fkf+w5a8+m+IWObVr
	aoTJeUXIt42+xRXjKmsCzTEjliHe6lqAV/6HQxo0H/0HTZTXYesd8+gx2QHlfItC
	Uew28HCg6lftgQb+cr7Mj5MnfKzClGCf0NxQGhPFOyFFZNWAElTdp0VHyA92Nsf9
	Dys7phUWfnLavtU7rZNonD8m8pk88xbX8sSZjkD/5YryOFt+sg1FIwW31MLvK0VZ
	D6JX7g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu1p4usgj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:43:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ec3314f65fso45653696d6.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 06:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850991; cv=none;
        d=google.com; s=arc-20260327;
        b=QZhiYGWnGi5sBIwWO3Zqvhq3Wmjwgp2CYrtyhj8ieiLsNHh/g2a44jf/kTLaSjFEjT
         il78rkbIngQwduShfsNdZiWx3Gnju2ZSKmVLsOBIHWQAV17GjwAPaTNagZoYOS48B+wc
         h7/HVUfRA7FdWY7Rh88MPSqjU6X0gEp6Pq7Sp3hUYXmQ48i8BMq869FpFheZwH6NrOpT
         P+druhmEQuypWPZ8lHG1X5jT24jzkJrMBD+KZ/UeVe7DPzi/MjTwguCFywVNZ14hFyOG
         GiBCrj2KZewTebzKHjwhUBKFz8I5KUk9ScpeAkTI9YW+VMwfugE3rSuFtzaDnB48/pOr
         NiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QWQr/x5bEL6Unr8s/2mTIOitfI4p3mr1jrf6Pl+pGJk=;
        fh=5ODzBM4MknTaZABd0NwzWhTTrI7u8yGdAxWiupqbU2Y=;
        b=i8+7zxIEpj1jCGqTItRK2Qq4T35+fFzv3kMTC6xZ1mRDBFSdO3x2PwPw/0Eegodzvm
         Y9uy0GerENpVncO/xUpAmBg5l+TqMmNz/yamGxuWz1b8y0L0mLdPIiR1KutnkTFHLzeR
         pX/TSVIZiMlXW+03MUyZ9uOkg3Uer7mF9lM9CCGiGyMIZATL5twfeo42K16MCYdS0gMQ
         PaXutobJO6eLlUMwMMI0SsjiBIwRdSgcL4axECd2rRhemlHZqe3O67LtgTboXcPn8aHr
         I7hxAiRY7uEX148D6N2tvgEoWEGz6H4XpeBL1+dzsgml8UWcPVURVeKUR8YnLRhf1Xex
         K3qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850991; x=1786455791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWQr/x5bEL6Unr8s/2mTIOitfI4p3mr1jrf6Pl+pGJk=;
        b=MZQslKWRcv5ULJPy3/9e0Lr8QrlZmnZ/9XLbE5GYSOpr9wLEcalSBa5ZNL4BIhEefb
         gWKkEnCAMLbRmGlXOpWJMsMNL7jRTkfgr5nThaNruYZMrlDJMpQNM83N2booE4iAe1kN
         MkJclyw6s6J5dLh5T52wa5pfRw/I2pyULfgYuaUJRsd8mVBZ96PD+UET11TaevicIFQO
         /Dk7CiIUDFgM5yCdnH0g4H7rW8oUbX0f87LE7rSngW83OuFgXnncn3Alfpdte25tCJey
         1SWe2f2SDYL1xy4JBe2zvFqgW+vcZgbwsXF9A4/payzciquWTs+KfNdc4msTGe2mKVoY
         DkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850991; x=1786455791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWQr/x5bEL6Unr8s/2mTIOitfI4p3mr1jrf6Pl+pGJk=;
        b=fJKhAhkl+IeLeH2987DpRLl0PXJpOnKLHUSfv/u/O32N8WCrUVtsVf1J6vMv35xkiE
         ZxUp82qysFWjx5f3aqAk27YFNFgXL3vesutdThBH8+NIIGwcrT7mZlL1yQ0J6vukIJn1
         VzkNOCAmV7oKC/5wR+/YJWqbHf5QonxgbE3eEirADd7CojPCXbsFIxXxjtEj8fz6avw4
         eIbsH1eUczt0Ty62k3hzGzUOL0ZLxWWPV0VbVpkQPXkvUJr1Pl7yzOEObOj3OYuDcvCx
         DfxApYu+ZYvv3qoiMC318QLMyUi+bPiR/ZP8jhRpWiGRYXG309FAQc3OV2Q/9oHow6II
         yKhw==
X-Forwarded-Encrypted: i=1; AHgh+RoxsJ95Vo+FOuP9PoBKZ3Jz3MtN3TJKedKTRpuLdKZ9gEVrNsWG+VHX8a4rJPqI+9g4fYQLoxYa+PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6sHRaMXxewB0b01aQjNXva6uOpT9BxXpmYcDkETTJnGirh/v
	49+OgZRgdM5byhgsjBawuKoMLZc6dXcAdDtqf5ywKw1gDGMtdNOK3oGQ0J2gOEzGBxgMGIqcs2Q
	7qXuI0VxCSyX1zBNJmhNEQ7BYBotb1b39NJwhxR9HAZrUyVfNwbrko4eVOUMaG2bvNRwDKGCr9Y
	cfRMwJVA8CzvEzwG4gskjy3FV94dAYxslB11melA==
X-Gm-Gg: AR+sD138yjjfF9ZrQB7Nq3AyHUwfNoFL4cAHs5MhkNH5kkzHZkOstgzk10ZwAvuPj6X
	JzFLBAFU9jUcvz1VJiXf+P7fuL5Apm0/TKz3if/qe1wUFxtwrLmDLS73HjbZeIu8vmitgt8A3L7
	MG4yZKk234I/uipnQuWKM1tNavTmg7H5j7euileJ3n2mgWdo09yw4M3hgkog==
X-Received: by 2002:a05:6214:20e5:b0:8f3:ba0f:e7b9 with SMTP id 6a1803df08f44-90849603117mr235603566d6.18.1785850990591;
        Tue, 04 Aug 2026 06:43:10 -0700 (PDT)
X-Received: by 2002:a05:6214:20e5:b0:8f3:ba0f:e7b9 with SMTP id
 6a1803df08f44-90849603117mr235602546d6.18.1785850990119; Tue, 04 Aug 2026
 06:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com> <20260730-block-as-nvmem-v9-1-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-1-f72935817dbf@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:42:57 +0200
X-Gm-Features: AUfX_mzk0wJt2Gak_njsh0rcAEI1svN-3axItB8B6ASWCCxtH7hxRBo8wnhVM-8
Message-ID: <CAPx+jO8rMUaw7MAYpfp4cLASZ75mfFD4n3NOi2wdHNVvnb4rbw@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=auOCzyZV c=1 sm=1 tr=0 ts=6a71ec6f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=F73tXhIjRpzWiH7OJSEA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 46BQB2ssc-qy5VxZV3La-OVZFsbHC-Nn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX3L1/OGcoWMJA
 YJYnWh9N0xPqr4C4YZRGddcu4fiAgO3uazo+T0Oc1mzP3UT/17JUIDKeAJSZQ5nsPU7V4JWfJKd
 kmiu53MtsF1lXhok4L8/dQProN+sQK8=
X-Proofpoint-GUID: 46BQB2ssc-qy5VxZV3La-OVZFsbHC-Nn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX3kCDj5o+SS3k
 585WqeJbM9AV/AhaTVAMrY6sfAzm1u18IvMghQdMM6UPmiukbg68O+iaO4vTwTZFxct3MlBoK/I
 Dt91WsA6TtFEWg/0pExh/g+bPkgeXru4MLJVMRq9NNa99fDP1q6eTwSslW4jY4mYDjMY8TmxBoF
 Ls5J6w4yLmsqgveQwusI49eEABpMcw6kNCYVDOYPVXaoZM+QJsGt71KAUj141JJWg6clcw/tlxg
 R8/WmeIiQDBcylEYFLJZId5yntQ8hFBNwDy78zDyMIFIjTQBeklnVn30QSFQXvbM9wxL6ocWu6b
 PYDPkXEle9ldt21xa2w7VOyoH/haQ1BqDndUqf2GKSdYInquJpgDcLzvGWkO8HeKe3Gonig5xjR
 wr68Wvd6CMvx+702MABIR1hy4xNVyYJ3bfdH2dweNyfLTL8EZIIJABQfBsGtqyCi9F7GXM39rFf
 VsAe3gcyFJJkbE97Eqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040110

On Thu, Jul 30, 2026 at 6:00=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Allow an eMMC hardware partition node to describe an NVMEM layout so the
> partition can be exposed as an NVMEM provider. This lets a partition
> (e.g. an eMMC boot partition) store device-specific information such as a
> WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
> cells.
>
> Accept "fixed-layout" as the partition node compatible, in addition to
> "fixed-partitions", so the layout can be described directly on the
> partition node.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

I don't think there is any reason to push this any further, the
updated mmc binding is ready to go. So, applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml          | 23 ++++++++++++++++=
+++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Docume=
ntation/devicetree/bindings/mmc/mmc-card.yaml
> index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b=
58a5fdbee218358 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> @@ -38,7 +38,9 @@ patternProperties:
>      properties:
>        compatible:
>          contains:
> -          const: fixed-partitions
> +          enum:
> +            - fixed-partitions
> +            - fixed-layout
>
>  required:
>    - compatible
> @@ -86,6 +88,25 @@ examples:
>                      read-only;
>                  };
>              };
> +
> +            partitions-boot2 {
> +                compatible =3D "fixed-layout";
> +
> +                #address-cells =3D <1>;
> +                #size-cells =3D <1>;
> +
> +                mac-addr@4400 {
> +                    compatible =3D "mac-base";
> +                    reg =3D <0x4400 0x6>;
> +                    #nvmem-cell-cells =3D <1>;
> +                };
> +
> +                bd-addr@5400 {
> +                    compatible =3D "mac-base";
> +                    reg =3D <0x5400 0x6>;
> +                    #nvmem-cell-cells =3D <1>;
> +                };
> +            };
>          };
>      };
>
>
> --
> 2.34.1
>
