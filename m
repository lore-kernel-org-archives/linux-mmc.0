Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400363A839B
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511757; cv=pass; b=a+H9ZXt8PquWV9QAsudE9e6SvGnPTQLUjXGUPK4L6YxMooX19Rp9O46HjqJuk9FTFmzoi/+129+pG+CjAu6tz77dcc3051C+uhlvNxt2yqhsasks3PrfDn3UeK2w6jl4+RXa6oJGWhIgXZtS+e/vqzUBNGhnctVz8bOahFTWouc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511757; c=relaxed/simple;
	bh=3ydj7XBZQ9qjFikBAdVfbnM6S28yhAGg+f/PA2X9pwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml1z+IlFX5VJASmTa34ppZWwhTjGvUfJp4pCoMRERpfS2OMYrbFotveNv1yoAqxtGP9GxRZXlV3s1WdXsmMqR3q4VZnk2vVD/IrvqC/Shh/a8RZl6slZ89AXN3R1oEsVUYgS35oFh/78Lo0BCC13Stw71R4fjAUGhGCHmB2GksY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LLLWgy7x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AyLJFVfn; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LLLWgy7x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AyLJFVfn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mlUx4111202
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 08:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OrXIcuGfiLa9DF8zcyadO4YQ6mRqklnE1QeIxy+wnqc=; b=LLLWgy7x5kHSkJEf
	cKUpXSkYGkLubmh33Qp1ekl3zR4KPpk8MrHnMN0GSSstVS5gLOMsisTCzd/08KgB
	+w7EE0lYZBQID94Ka80EKQSn4C7KMZH6iivHtoVjKTxEXgTZNCHq6lKuQfvI5rSB
	Mkqip1Hfrq2rKNSkjV19duUZkHXbKiqub50XxgcfzoUdl4JuPBK5cZUx8mCpyjQp
	HG+SQAgl/fdh/g/H9Eo/baAdCSHZ8jekrCA31dMZb4RwFkLik1E793hGiuMwCZd3
	e/TR77OzaVLgdZhwzy6ouWFeVJanyqRop2MboGj2L9Fit1v6dapoEftLimQsn5Q1
	3HNWVA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf9b1cc62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 08:49:14 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc2229450b4so966199a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 01:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788511754; cv=none;
        d=google.com; s=arc-20260327;
        b=JdRX8/3ZMwGoxiHQHkoRJSY8Mj87xZdOZbwqm2moAMgWpMY1AblK3MLCxFFSVBoSeV
         PZ3h66FyCTAsaF6fcJh3rU1Orwh36w96pPlLWPB+8Annr1Le+WHpw7t5khSdsaXcB+q1
         GdHbvCd2ZJSEedAdq38GWRquc3WM4cJMFQXwx1vrI1eO705sNe4kZG4pk3OLPCqWRROH
         z37b2ACmZkenZNm3pgeHbM4Uvj1tYgw4AznkRjaVQZJk76F0pwk0qDE6Sa/ajicyAAWp
         7iWTt+WqEDlpsw4n1oyb9JzII1qsXMrg3ZJe8mtEMS82s9ZsDBMj+B7Iz542IKW/8GIw
         Iipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrXIcuGfiLa9DF8zcyadO4YQ6mRqklnE1QeIxy+wnqc=;
        fh=uy0hzqBRVTVFHhIX0C/7OjYnFWK6NH+BzcsR0waMFhI=;
        b=nlLBoKCy6DPhOM1IiI9stUCb2OvV57jUeDOaLyEEa8MBt/veys3cs4aybM2coY2nnt
         RinMvd7BsG+uzFeAuxBwD6YwasWVkFCWVsL8eyamNySkHLK0V4q3rZ7Jbo7G/n6KORtD
         s+/CFl9hsjyfo2Y+gtVKbKfWL8p/8I7rBPmmohm1UF3YKWKGi0AQM8k8T9XJcK148yzQ
         OCYoV3XgPybHTd0Q+cEnyDDTdU351NtQhv0i15GvjWve6ZQLcr0LVC0wVxJViSFmudGC
         5SWH/Yq+Gi+95YBbGXks+1Ru5pMv2U8gg6fE2Q6tmrZG/BATU+YRM1JjIAJ27cLX54oY
         H2kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788511754; x=1789116554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OrXIcuGfiLa9DF8zcyadO4YQ6mRqklnE1QeIxy+wnqc=;
        b=AyLJFVfnSOsJPnVa2eMP9v1XYmaKZaaO171Y28gEiS7/8RvG7aasmY9GKHTgFudz0L
         LhRDYYExx0/Px2Wu6unChdED87q3wrKB3AoeQMpE9RuU0I/EUqv5EMz4na3OXdCvMu9t
         mhbQYA54zhRuuZI+9dDOlnO0FJEedi5zsAIOhmlY9PYNRhfVg3d0A9BzOgeCsa+nEZYn
         ojOn8eBE4VAX6ADmXJt649dUeiBj1IE2vezoFVhw2wD9TR3I0t2yYAEjhuB2TByUJb3C
         WXj3NS/v8ErKBoBbDDP/fTgUil+5jTa9PfCXcEJqZoInkfs0wq640zTNn6r787FbJBAi
         V/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511754; x=1789116554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OrXIcuGfiLa9DF8zcyadO4YQ6mRqklnE1QeIxy+wnqc=;
        b=LvnZeSSjKsj5G8ULHs8g9+0YDmmqWC+OkzQqPWZG74LL/pES26lBAvvdJlVkcauSSh
         B1gYwzpDWc9Htc3Cbq4J1/d0s/vrJJZyU+V2VsjNsiFqnohty5eTEYxkXBFq5aPjaZZF
         fcQ2CA7kR8spRIaaC3oN8CVXlh6JDY11XQTxOXE2vnu578EQsRrGtIpzab6sBIUMOZ0i
         Is2l3FWz3g3ONmaQFOC6AkmcCYSRsCauj7kb2kLKz9kApshN2hTJ7Xepd9ObCoBTDg1T
         HPgVpw5rmf5j9tuKvy3Qv+6J2kcGRiVEUwrj+TOMsYzzs6CpdESTbU6C8CCt5GyxNFeI
         Nebg==
X-Forwarded-Encrypted: i=1; AKwUvBwzyvJXzuhCrnviPmCkf0go9k4n76mXjLJxYO66CygrWbiCDL5wnd9rRtUUcaRgYpPrfnGkmlIQQpY=@vger.kernel.org
X-Gm-Message-State: AFuF++lDw/2p1eRMKL+BHDjVt1Ri/u7YbdPebS74u6+VmtJ8iZFt/ZsY
	9YnlriW1sgaEH3o2lHXYX/mMLtVaPZLnivPLnKQsH893NR95G4A1BXGMBpFRIDvY7MnzOQ15qe2
	+erEMt0uEVy51z1bdezoYyCqgtczWvc3ECWOvN4lCLG/FLqOhxY6pnldG1hm3odYAMImjr8sFPY
	u4itW+CC5rQ4621EZCh+ddfwXhZ/1QaMWbqgxflw==
X-Gm-Gg: AYBFou10DLzCANWc1/HF/sCL3ZVd7i3v8zXXuYpYoqo7GSkfT8rGT5fmNSlP5AfrYu8
	UpEq9Gb8mSwHEcjAa1fcve80c/rDQgMBgWWDH+Aupx2Nv5i6L6zDx1lQaXic8ivYJRKiO6diw0i
	I7lWWfFSIYJf5w/HjVObgIelnW9o1imyV1qt1q0RDeSE9PO19vXe/bX+hoeg==
X-Received: by 2002:a05:6a20:b418:b0:3d3:adbf:7777 with SMTP id adf61e73a8af0-3da3a066ef5mr7202834637.19.1788511753697;
        Fri, 04 Sep 2026 01:49:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:b418:b0:3d3:adbf:7777 with SMTP id
 adf61e73a8af0-3da3a066ef5mr7202771637.19.1788511753245; Fri, 04 Sep 2026
 01:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com> <20260806-block-as-nvmem-v10-1-be598b2a5606@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-1-be598b2a5606@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:49:01 +0200
X-Gm-Features: AcwNN1Uv_B6HKhzdhsS9aNd75U_pKuJYfQt9a9aPW0x1SCz-kw1mAB0yNJHs0Mo
Message-ID: <CAPx+jO90ut8ZPh51BPyJLpTT5u1i9HTWKyNUWRsFdH+mD1uqgQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/10] dt-bindings: mmc: Document fixed-layout NVMEM
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
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: gDLiiTuh3jaVhfmRbr9vhNk6_uVtt5wE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfXwu/kZF4Fz4yY
 VQrSV+GOKrkvsSn76v4tzgX9eY5FNJrqQYD7uatYSp2FvwQLzJ4YiawTZ/IDwBzT5vpPRRxLDle
 qODacXj2vW5X8iwRJKXJnBxNhp4NL6c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX1lxYSlYQwf7P
 ImScn+eFwx5NMzzfAws6WmzuDpdXUOC/CMFgCt9DEudcih3pTBzmvOWWY7v54P0iVVTU/o15SGU
 DaSzvI7g0lqew5gg8ObymzrMxOl8CzVHAhtqz70OkMwUSGu3svaC456a+isjaW0eshluaZVp0O0
 4jHpf+EXFdAItxmk4GjXfWoU5RYzb0DH3a8FUN4etnfXCV+m42TbogByY4tLgAj15SvrJHWmMxm
 B/OOnPvT8rPXDCv+QEgsrVT/wLBIarPOvdynnApJ8BvCgolgXtcuCvwHJDLIMIfWAl6EoWRGMD/
 u9TLd/ZkFNp16pAV03QW/epXZfQW+tOj8o805x9fg980GW9qQSGTqcdQE8YkIuLeQi5qyXjFwtG
 G3wSFfQm5/2q7my2SnB+PHQ3qqU3VtI0EAWBQo1G3qq68I1jg5rd0v8LO115chDofaSeZVF3cgb
 0RySvQL+sFdMoWnseQA==
X-Authority-Analysis: v=2.4 cv=NNTlPU6g c=1 sm=1 tr=0 ts=6a9a860a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=_Mn6x9y97Zr2TNExHCMA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: gDLiiTuh3jaVhfmRbr9vhNk6_uVtt5wE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040080

On Thu, Aug 6, 2026 at 4:38=E2=80=AFPM Loic Poulain
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
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

FYI, this one is already in v7.3-rc1.

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
