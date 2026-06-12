Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B53D6CA0
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251087; cv=pass; b=tNCEcFU27rS5GFcru7/o1YAdvpjKw7ExLX2Mq3Co3d5EtnaBY9HR21Wba7l0ahPBEqvYQ+OLYSh1wAUhTY+tKXGZlmZWVwrdx7d9w0DFCBL5e9sGWxydI40YJ6lMGkYTBWQ5TKoBAGtNq7VuIspEypo2SE2i+9GqPWvO0r2xdJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251087; c=relaxed/simple;
	bh=qE9FqkhndnGAaai2XsKnxnIlLJwWvj+Km/dAKpVTNrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGadjkC3+tchJYSZY7Z39NEUqyaViBQM2SkrwlS5KpVRl9Y/JNLiSCj26PpaglWWiNrSO1hd0f4zVDfzaRqugPFeCRwnDfCtrLKk34pmQQnQ+4AplGRq380BKtgIaa1L52edZi2Lp+097AP7K8jd+pTEfLgFCWfLuE/HpDHzuUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Be5VGx4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=POCygWzX; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Be5VGx4g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="POCygWzX"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39SZ72475913
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=; b=Be5VGx4gTUql8Vgx
	MQd5cd2DNjjeytK/wVvLvtoz/4GCK43dIUZNL2r5LzQm64n2OSWrhgsu+S17nxAi
	biRk5OxZn7ZLEuhzG1n7N1H1hG/Hvyl2ZjPusePOMwVKv9m/jpnfo1fPGG08gdKR
	qjpflDb4jHHwjQa8Hms9E7dNyqZ39kDJ6WjummOJ8TE1sUe+W1gQWbbpKqallgw2
	orSXB+5jHzb3rVakigr3LCMzzfgBUFMlcjyakZw0BgPrmAKnvLwwQHbUHdJKNklW
	3TPJmVF/kb7CIXaZBB5jiYLL1964zpfhv1RNhb8810SNEDTCKV+lesMe5jgvamy9
	2ZUL6A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r5t596-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91598ab3a1aso86595685a.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781251084; cv=none;
        d=google.com; s=arc-20240605;
        b=IVWrlgwhoADO2vd81xuVuWord+10dJ1SJddLvptXur/eH3DIzzxenwENhRmFas+hNN
         nGZMMzr9yOCsIwDRysZu+XN1tm555peNCp0OetqgP0aY/D4EeanmiwTLYnQZR/Yangin
         cNDd8YtE8Dn1vqnG3M4vc0GZ9rqlG6TFiDpNKKoIAFRZrjKqNddKkTXLW+TOS5HFj+hs
         Fzt6WSXcMr4S2/QAQx9qZc7wpFPvY2/h0Kmv6lrZ4107Tj7aog0BcZJ1hKcbzpEWrIPU
         1r11AvE2l8lF8YEwwAiaD/IFELr5ycFvlIzawgYTlfCh93+VCJwVVJcDixgMtUfnXU3K
         Iauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        fh=hcj1wlUXjKTVGMwpKTIwDp4h9Ec77QDnJPcs2ygmIjg=;
        b=OXgJyfBZkUa/nw5A+BkWZAlDre/1FE1sDpw41TT58WSJYOech2Xb8uedB+fBowNIV2
         e6qQqhUTIUja3xmZfGkXSlfk4iQeJYxW4+oDdZvbZFHNCWTyQGOJNv4yNdLjfXttm2z+
         k6HEYoqiQlliZYAG7pVR7/bu+XKKCz/Uk2uu5C5j8gL9NLPgYJx54pQE4HjhQsbD6CjK
         z+BaagNKn1AvGNBSI12Z08gMDHwqk41AOpW38WHOQxJafYowQdPV/n6O4mSsOr7CUjem
         oub+G6uI0mL0CjlPce+9SGOgLLoVz7RXHECop9+4pXHu2ADlNLbSuwU3Fhbj5d9DiXxj
         e35Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781251084; x=1781855884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=POCygWzXRhSGiDVOhcRBLv6GKKii028tspR9dtQ09i0fzdtpSdNHuDevaXhLi6vHss
         ygGYWvQZbhMAC81YgzG4ky6au+Aua6+am2FqMiJhu3Y3LaJ4FGkhOEDPcjsrG6m1KBQQ
         yNBwDK9HoxMy+koaGykJHN6A2niBDo0j5ZUzA8DHNa59qy0PB3Avr7UeTSut7kbfmLGo
         twkUgFRDoX/IYqaGw5P6zSSpiraKk+7uAdgurVbxgLX4MiLriUXStmObAM6S8a8BcDSC
         DgcbBvyIHfUbBW3qxP98JRx1PPzmyY1kgcRfeq9GqcxrtlQqokXWNRSyrn+Yxc6WtzJr
         aTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251084; x=1781855884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=WdgeWuOY80Gl40GdywFbACVqtmciQSMMWgKBP3uR2jj+ba3Ge45ycq9fenRnyn/Zlh
         Uy7l1LMyk0jvgCsWOA8SQLWyWe9W8CVM7hzfLocDkf1GqcsRgDBzHvezVytHgaA4sM+a
         tgByeNL24+vFPl1L6EtJzzfBWAWUPdoiJbAh9KScVb2LtduPH8nN2kKRxk34BN5tKaaW
         RJb5HGuE/EFQMVTP0cd5uZLOElfdFf8VgZk5KVW+2cURwE0lAmiL8UZhOuIJu8TizlLK
         YEF2NLmalpR3Rt5n6wB1KsiHXkEQB6Jl2cm7PH9/5gL9Ftmkgk2sFxgFOjpcJ9X8RS+f
         n/3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8j1aFFkQu2QAUbfDCidVRyUWkhUirkyB1hkm3+MUoWHwdAERQnE9egDCq5Y/O3CiV/7Q8SGqhgyjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybDQ3UL5t5z0KNgr3kH2/uvze4IV28M9+vKvy9nQErOuOSoBNA
	odKN+MIHE4es4wxTx9Vwnfeq3lI46gm1O9OYIKCMwFMooMrblAr1tfQxujAeTNcWfD9VcKB9OVJ
	7Kt0pBYV3UVrPTInM56lpQl3p8kdKc8+N0u4cDVLi2eStSLU3D+BufM1bTr8LDj3yXmgTUXx9sw
	QFlak39uGlwKmmyocV0kHeIXRRRFgS77djbhfDKA==
X-Gm-Gg: Acq92OEBENCC34jb6RwWhSlO6RQKDUF2Md0XBDGoBRFltGauVV/qliWoU2FQZkf+N70
	qhUI8dSTXuCXtlfsO7r0JHR/7ACVSxrKbb9Qm0VocC38JoyyPGNKjiVoe9O+pfoBryIrRKbnt9a
	FwzHVFJ/VM2Ibz2ByxCa51prgoFXeIJPPqW1kRfy6/Oc1vaaMdCtLRRcp28RNvwXHlsBmGVrbwf
	eIlNjAwpWRdjztCcrrM8FU9vYwFjMDJC2JiMy+mkP2a9+IDBcXMLE1Mizn7LWfx6+QH8xkRzzO4
	deg8P4ojOByWV6v8Kj9Q
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id af79cd13be357-9161bc5db30mr150538785a.20.1781251084090;
        Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id
 af79cd13be357-9161bc5db30mr150534285a.20.1781251083533; Fri, 12 Jun 2026
 00:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-2-45712e6b22c6@oss.qualcomm.com> <20260610-funny-paper-warthog-25fa0a@quoll>
In-Reply-To: <20260610-funny-paper-warthog-25fa0a@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 09:57:52 +0200
X-Gm-Features: AVVi8Ce9FPbWU1H1fFzoHrS06e66vPYKJ71XBeMTddYgFQq0vpvNpz1VnR725W4
Message-ID: <CAFEp6-0Jqw4HqTu89QVOVtWEYMpNdnd0vYxRyZDgn6oMENCqTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
To: Krzysztof Kozlowski <krzk@kernel.org>
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
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: jYZTHYE4Agv2Pkh2m1Js0IIy-ULr3FhF
X-Proofpoint-GUID: jYZTHYE4Agv2Pkh2m1Js0IIy-ULr3FhF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfX2HUy2MWNpfRJ
 /8Bo1yt2NlteeJs3P5m985Dcvg9PFfTP+UZVeYyOOkEcfZt7Bin+zMXhx2e7X7KHJcNqLjzthnA
 nbQCkXaJxEMCA0tBmvOHx61JY0IXsUw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfX77JSqIgq/dB3
 4PNb0jAMjOWxQEKPDf7OSLVPqLxVrTu792PBMTEa0rAznr/KORUQiNW7c0NC25PupVFbnz9+XdL
 eU4ZaAiWnBinGZ4i5IaeiE4xdpJiqjC88mrPHsTawZXU+Zoqibey5CRkZTMTdKeG53aPn6MbMNo
 eBQxQbRcV5uvxBkYzG1tP1Epvj8qSJCeJtYJGKVgsTLyVE41P/WrH9+cfctpb4WK2DaIQ8t3nq/
 RTkTrPRcpa9l4qAw8PTUgI2nZzEjoWgVZse2KF90R5KS4kWy5ZW2cNART2qDUZ+AuF081Q6/Y5D
 pLsrAgZJoHfnrPJ/4gqH8rVjJmokbvlHGuFAu0UNCBsNcVVoSs1U410CgrmyYhbfLT1lWFl0V1K
 s90g9oe3fZtEhEFGgip7Wnm7VlAwxJQt/J3lmDP4t1kDTO2OxNn2K99EGQOp+VjnBFooYpiMlvP
 PehcToL2l6i85SbbOkg==
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a2bbc0d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=HRdx1Oj2DPauqesJAvUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120071

On Wed, Jun 10, 2026 at 9:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Jun 09, 2026 at 09:52:27AM +0200, Loic Poulain wrote:
> > Document the NVMEM cells supported by the ath10k driver, the
> > mac-address, pre-calibration data, and calibration data.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++=
++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k=
.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b=
9919d48c41ac09f1e 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > @@ -92,6 +92,22 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  nvmem-cells:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: |
>
> If there is going to be resend:
> Do not need '|' unless you need to preserve formatting.

Sure, thanks.

>
> > +      References to nvmem cells for MAC address and/or calibration dat=
a.
> > +      Supported cell names are mac-address, calibration, and pre-calib=
ration.
> > +
> > +  nvmem-cell-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    items:
> > +      enum:
> > +        - mac-address
> > +        - calibration
> > +        - pre-calibration
>
> This means you expect random order with variable number of items. Is
> that intentional? If yes, please provide short explanation in the commit
> msg.

Yes we may or may have any of those cells. Will document.

Thanks,
Loic
