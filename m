Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB123F410B
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270469; cv=none; b=UQ0UlPqdSCFD+Wu5t8IRCoy5znEdU9mOazaDmpjBF+hZlrF3lu9xAH+yxpI8NWbLTwe+8FWqdW28jIti7pRm623vR4oTMtDp1rTm4N19DYuAUTL/rNOgTJJxd+JCvV0iobj0WHhkqCkry7tme3aaRaqvYEL+ZaBLsqi1vPMEkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270469; c=relaxed/simple;
	bh=X0Ai0achBf+ZwxyXQCLBkT4mksbIzc1fznSydl00GqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qi9D/Q5IQ0MnRGjpkIh9Z8RlDfGuJebWvQNJAuvfvH7gF6uMmlXQ5i44qxHnZ/jy71QkwbcSAro5/8R+HkXCKCwjmESCArAUJ76GAqdxmvdhd5SBNQ3bRbQG70nkrynfD95jGIZShpYfR2u9UEstSmTWthZMkNKEMYyCTHFUCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ewQgfnCL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P9Xl72Qz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ewQgfnCL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P9Xl72Qz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCijCd3747567
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=; b=ewQgfnCLI68ej6Qo
	9OvW3Hi1cjrVzZolpkfEcfXgnbQl6gVVUQe/0Yp0LuwgvD0Qsc5IdUDcrmpsOF7V
	Z/vHzjH/RTaUpBynaPr3gFnmOdDpnUNPNDzQPhYR+o99ADjRTwBodu9jeRTtmWvz
	te2fZaZFzkN4i1pVF6a9pk9+tSgxqW+YMd+WkNoL7CrS0KCHdRVFHbfvKF7kvEZi
	wgOgDbXctH61qgfVv8uE9WrR9AZtA6dq0Dc9JuSq3QgoIBeREWczdf+29NpOtvH/
	dZPxZfyuZezJJmJ7EZ7SwhXPEK3ThzjcIIOlzKvyJhxy9QkoLOOJ1VYlLWUX/Yrz
	NCLHdQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76ehy7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:06 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e71e43e89bso1334254a34.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270466; x=1781875266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=P9Xl72QzhYLQXH/GBjYt6pTxXaZxUAwgL5u7OR3qDUVugoEEJtZftcymlbbYBGp/cE
         po5pwnoP9UU3t/Pq2SD679RUS5fifmLbihW06h7c72WZF1vKC04YXaQzNuB0oQkb1ReP
         y/AE8ZKaEYUx7Ns/ZAg67tHRAsP1BpN8c148s1F4iQC4rlNInUuYRQfjTSezvaKy2UqC
         k3j/kgDoAgcxhKLAJ4XVdlO51caiRh/AfVz4+P3PGenuM0/3Iv9+BTRB23XIq9X0m9TN
         vj3U1Y5//t8nGLTuTTx2yeQLLX3HOwteqBpKqkJOKFPOvlUoWZEPQb14J46uXbnZM8AE
         Thhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270466; x=1781875266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=c/aH8HpzxfO+pFoaLESOz1awemb4raQedqpPXd2pWC5cqc3AbjMAs8U+ZdbYxHsYjj
         PMZuibYcgFe7yvafconCsjxs/9ERzoBlZppdGWo71kTJANV9c5qWBVQtprBVhDLM6M6R
         07g2JIHNDmqQSxo3CBKYNoFk/++umHLB7HRbA9xDaoE8LJUJEAN+3qAGldnImEtZsWFF
         ZaTKHHVz6ZzVq+9/B9RTX1WbWlDVsD3bh2svrGp01sGAYcBvDAixHkVVBdudjSCe5wSi
         rr5qDV+dI6xVX2Yxu8uIolxT1Aw3wRQVmB1ojy7U31PRCFJSHAcrwNzKbfgP4EtNBajj
         8XIw==
X-Gm-Message-State: AOJu0Yydwaz5aZiROCkJ769ujPmD+/THQ280ax8tlTzR+XESoToyLfXe
	ljxGV7SeHjDpsfKa5nWk/cOGSAPTZ9SvbzinRt9ztCgEDaO1RSUVDkzgHmt2Ks5hWKpozIvG/pz
	ZHDuoSsLEh8XNr5/sbt18SvgokAJhrEY4CLn1TixYuR7HMe/AB8DzzckzT/xHcFk=
X-Gm-Gg: Acq92OHw0IWJt3pNicwivlVFVmqAQ+j4LojyIfuxPsupZxd7ITHorFO+fN9tn/h58rI
	94D3GCaceeUbu287TWobJ2XeR1iJ34YFSRvbmdUaWUa/MUUvYGmyWl4j6lgHMv2m5ear9tvHrBQ
	KVZQ4GVBLzCibN3hO0oNzAOOSib+2+reu3CIolVEwtpqwx41E7i41TWJkKoXFDSF+uDFx6hnfMu
	iVFdgpDDD9EGeRbqL28We28/7tuiYjrtV5WcroeYKaf39jk9VGSiKGXN2CucWt+wau/PVjzqUYl
	9cGN3m5d3HW0uLlsCu98y3OvuOhrYOou5tztfYlBHTwuW7s3M7U5UUA8aoZWWrCl9BrQur2f9rj
	XVyUQK+PW/eZ6dy/Z3XuOoYy5b+exjxCPHKoTyI+ERa6t5Jl1HFEmCv3SyjIyXkooaOEst0S1CI
	9Jm9l6Jt0qgfHLQtown0wggc032evCnH3MxAtTkug8qaAWY0JomVx4HUr5o8ZM46njoR286slr
X-Received: by 2002:a05:6820:6ac5:b0:69b:196a:de67 with SMTP id 006d021491bc7-69edc38e930mr1694337eaf.0.1781270466088;
        Fri, 12 Jun 2026 06:21:06 -0700 (PDT)
X-Received: by 2002:a05:6820:6ac5:b0:69b:196a:de67 with SMTP id 006d021491bc7-69edc38e930mr1694292eaf.0.1781270465641;
        Fri, 12 Jun 2026 06:21:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:54 +0200
Subject: [PATCH v5 2/9] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-2-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2c07c2 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9i5gzfhGLSn5NVSMExYA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: v6qRT4PZsncK9HiUboiEJ2Dm9NeEj5oh
X-Proofpoint-GUID: v6qRT4PZsncK9HiUboiEJ2Dm9NeEj5oh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX+GzLlhXP81Zh
 QfIid3OwpwxX7K26kOgBBQtQ+oqWkB9AZmCQe2+y5AuN7p01YJB1887j9mrURa9PcVRvshN6R9v
 6NJWwZAtTAWPbuZ2VOD3oV8ylKusIfEAuNeEQfvGncqvGcH76sH4aod9B4+Ic6nNyIBMUcOkeFl
 RxMsVCNXAkmL4LHKRCbJyUpY4dD2u1ArdgwLu32HepUPmuQ3Kw3jIV9gFV5KKuFgO8w9L/Z/6Nu
 pjryB9zLl1afb6sASsYnQdKh69qJ3i2+msbvrUt9FZPnU9Dl93VFh4zmswqCiN9mnJOPKxGuniE
 FlvKaF1Ct+o8SitrA3IKzIe6f/4iAMjfTce3sASK3O5YBSNpmhNs6LX6tv8VpKZHdDiIw9oeG17
 LXAD5ZmyuNaljgSudeekNSz2fK4TZjgGbW/3qh6FvLxec4IaTbSTFAcvoi0tZxm77f5bkg7eDld
 JLMWNiekAKt2cx2ztWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX5xiBT0td288b
 Wm1kHGgnPymZy23zvUBJV8GHijGQivMDQNljKBgwKaNHcPFK8xrCwHqsByyXKWQ+a/MvUXQaTi3
 YlidRYyxcF86O6twsF1mXEis00PGioM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120122

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..ca907ad73095925b234b119948f94ae81e698c86 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -40,6 +40,9 @@ patternProperties:
         contains:
           const: fixed-partitions
 
+      nvmem-layout:
+        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+
 required:
   - compatible
   - reg
@@ -86,6 +89,32 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-partitions";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    mac-addr@4400 {
+                        compatible = "mac-base";
+                        reg = <0x4400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+
+                    bd-addr@5400 {
+                        compatible = "mac-base";
+                        reg = <0x5400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
         };
     };
 

-- 
2.34.1

