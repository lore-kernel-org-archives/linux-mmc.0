Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9B25E469
	for <linux-mmc@vger.kernel.org>; Thu,  4 Sep 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014640; cv=none; b=bH25xxE0gPd6rhajt9xwbI4oygwvo0n4dwBBbvIWKz734rE1RD6d4Bjm3O2/7ZnsEElD0njwM63ihy3uL4CKEBIJX9DVo6x+WO6qzOzWuxO1PeHEoWY12l2Zp/8H4etY2wYfUP7lRsM/kWAnaBtjAFPzG5TgbNh+5XwX9fuTUCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014640; c=relaxed/simple;
	bh=1zQV/s94K5+h1YGZQMxFS9OiOGoj2u4JLZMij034Jf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALbPUcC1PYravTi66DskPtGdewgAgFzzSZTvLRmp3SLcBfTlWQHV/BpgUXf8jDdkjCh+UlhMutjRiCb0gi+pUiYq6m66UtWW67S3h/ptAsQbAzNyskhaT/LjRB6Wq+3ixyk6bbc+Xn3G6o6VdOWLjAblPOIYO0EWaCghSiSmMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jlg3M5QX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlg3M5QX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IjSCr003296
	for <linux-mmc@vger.kernel.org>; Thu, 4 Sep 2025 19:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=McF2iXJTB0tw0p4n9n5WkRjm
	CGCLSHcRJu0PgH1a76w=; b=jlg3M5QXeLWp6cVDKBdqs6MOn5pkhdF00WH6DkWT
	hHmjLm8bkq10x6uamdNnRlTgwxF+viCZ3Huv5/2qTt82Fr2AiOWVDnLdSWD0U20d
	l3N2s6AQvK0U7i2ayG5jxamGjaqqKzRxxAX1V77hhS1lGpy8kB2vOm7+u2nwKdLP
	dY3nZYSxG5/aI9ghuT81Nr5pTiGdhcmFVTM3Ltiq/3Sn6K7tQLWpMN3gxhhoE7Fu
	rxt8nm/FQTVy00djexljCwo3be0iqspg+bn0c/7WhVei4VDHAT+c0UzAy6jwBKB6
	B4NkLGp/mR4Hcg+7Gg2CQZaEeYKyZejXI61LeW81UoHwKw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush38jrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 19:37:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4fae9f22c2so1757767a12.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2025 12:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014638; x=1757619438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McF2iXJTB0tw0p4n9n5WkRjmCGCLSHcRJu0PgH1a76w=;
        b=LS6Eejm6+ez6h0nTAzFzsM/tiPL/1gQ/Z2i5DHsX63hlMSs5mhN2U79blLJhDB74WE
         Ct9qAsQSVnVlr3taNqu3xqcTteSvJkBBSjqdshowSHQmCFBeTbZLid1cN3VobAnkLFmW
         s7h6BCOiUWBExcJhHuzPfcSAZiec3wsQEUBCN6urCjAe8fjIY+RJ3ZrPS7ALh7p8os3f
         9JveLGg10rd5LY38ZghGghXuMXllSZ+/MmFmuAvXPno0LnOsTnerSC2WB3C2APNFtDfq
         9QPVKpA4V5NumcpxSp2gWITphzIzKvmqSfQP+7H0SieDvcSZxOY3HQL30VJqbd/dWPFR
         qodA==
X-Forwarded-Encrypted: i=1; AJvYcCXnJjvpi69UfEuLnuf9+eBuGDCmiCmc6uqjj9QMAFkcc6Swyz7fttdRbekdRJTCisjdxGr9tjsNzM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSYW8mlyVj4z0qBDi4o8+QG9+Aqn4kZpOvd6YUch4KIBT+tV6
	mNHq6Y6DdDbecFeF4ANHwvZs9786n23lBD1iW5q7oTSqALoguouSNDmSFjmGvr63dqMrrLwvtqb
	jJ0aDmCcYacnrz7so099nAy4WxTQUryH70iSKveHZ4IfO3kw8BZMllbRDfia4gzM=
X-Gm-Gg: ASbGncuij2BTWobpR9X8Z96zlfQOA3nfI1tv7TNAAbKvjUJcSuGUnBbw6g1DMxj/Fwg
	ckPP6IZ26dN2HwjO0NEj45V3VUZMhXsIH6isRbUVzt09uEm0zzOR2XxK6DC3w9DXNufRUYww/Jm
	8vvBM2DUDvyAqdq7BHp1GnzSxWten17If05rikHFG+slwC1+OLOMi17s7hZvW2myP87tGoFd8fS
	+DZAhwuadGIiutK9dD1IbylW4BGE0wbZVQwkXGo5hSz/kPtvV2DmRhNh1r26mz/ZhsUSG6NntVk
	H9eAsNs7SuLgGbWYqjv7Izsuv+ukR6rj/gzMLBqLl4Bba5pdIbxlyXotoAaN+Es8d8d2
X-Received: by 2002:a17:903:ac3:b0:24c:a269:b6d7 with SMTP id d9443c01a7336-24ce9b57ba6mr14192465ad.50.1757014637698;
        Thu, 04 Sep 2025 12:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8wfQGHYpfVwabKJx2d0rjdTjkyrNxzu2OZBEviz2cswh6mp15XKTFFB6XMS1SDaXgiS2CFg==
X-Received: by 2002:a17:903:ac3:b0:24c:a269:b6d7 with SMTP id d9443c01a7336-24ce9b57ba6mr14192115ad.50.1757014637195;
        Thu, 04 Sep 2025 12:37:17 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd655823sm20856515ad.114.2025.09.04.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 12:37:16 -0700 (PDT)
Date: Fri, 5 Sep 2025 01:07:10 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Message-ID: <aLnqZktduc/aT05R@hu-wasimn-hyd.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
 <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX0Ve/zBSQEZNI
 f63bliRMG7X6QDKFY/dffaHAD//2om7MuB+TjAo5DlGn7zoddhIGaVskqPecHSf4lWp4/yN5AkU
 RLA9OPvzmw9RZUgUiNBFgksjNMmZc1ggwKCNsRiaE/kboV3YjcH93zgj4eJ9zAT8RAZHwUfl6YE
 4ZadjGjBXpJ2Se+ECa2tn5nZmVMreQqnOp7TjQp/95mf0VqRxmtrmQ2jkhh6tPaOdf9ygTKUNTF
 A1+ty6H2PTI6HMLAlQ8LDxE78SzeKCFFwYu2/Dgor9IOCM/pySU6ceLAxrgVuYHEb/ciaCEGbfh
 s9jpgJG1N0SpCQIfUTxtXnYNRuAnY3HN+6rKpD5pZT9Q4qQVnDKI8o0znGuH25LGuTzrNb5+Oil
 rrq/zqxs
X-Proofpoint-ORIG-GUID: JOBm9LCpInWUfL6X0N-LXUdx62AY_bwW
X-Proofpoint-GUID: JOBm9LCpInWUfL6X0N-LXUdx62AY_bwW
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b9ea6e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IAxE5SYkeMM4qmkgMe8A:9
 a=CjuIK1q_8ugA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On Thu, Sep 04, 2025 at 07:43:27PM +0300, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 10:09:01PM +0530, Wasim Nazir wrote:
> > Add the compatible for 256Kb EEPROM from Giantec.
> 
> Why? Don't describe the change, describe the reason for the change.
> 

Let me know if this properly describe the reason:

---
dt-bindings: eeprom: at24: Add compatible for Giantec GT24C256C

The gt24c256c is another 24c256 compatible EEPROM, and does not
follow the generic name matching, so add a separate compatible for it.
This ensures accurate device-tree representation and enables proper
kernel support for systems using this part.
---

> > 
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > index 0ac68646c077..50af7ccf6e21 100644
> > --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> > +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > @@ -143,6 +143,7 @@ properties:
> >            - const: atmel,24c128
> >        - items:
> >            - enum:
> > +              - giantec,gt24c256c
> >                - puya,p24c256c
> >            - const: atmel,24c256
> >        - items:
> > 
> > -- 
> > 2.51.0
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
Regards,
Wasim
