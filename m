Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3739E9AC
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352591; cv=none; b=YyljCd27eTyB5I1yAf6ilUEp1Q8iiJh68Ak/aPd/11hJ2rOlzTdzFMszLYOeTz+ksy39f4D9WjX6hoKAPh74hOC3xeCiI3Boe3lRgwX+eaVSaQqip4ydPV/ddj4ocuBJdG6Rnc3QFG+Lmo6eksxdVHU4sTLHk3jNPRsvWl33PL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352591; c=relaxed/simple;
	bh=CwItkLrLHSd7HDH+CbzHL1d/wZCh5pBtURA4J5rNpws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mnwwkb6JBfXI8mVqA+8TNOAUqU4r2c4JhM+4APHnndr712XJ03OLxv3+BaGi0gKJQ/M/puRklvW4eEWosGvCMLXOMSoLC3fmSx+8vep8mCqd2/p4w2+tPq9eZhnviPZkabdevDq4msfRvSMqfyWkr1RSOPVovLj+ys95UFHxTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J4UEf/gY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c/XLZvSa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J4UEf/gY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/XLZvSa"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFGbQ809794
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nTSLcAtdK3ET0t7jfA4Z2GusLiBXn7g1inI
	dhOUoCy8=; b=J4UEf/gY++dBb9U4yFLeSoHtLEOv1pWFb1XYDVVS1lzFENKeRva
	LOPe1Vvj5Os2dsmEbZPo5b5caGq+B1HMcBIeJU0FzBv9BKenuZx0toDtJhNRvt/D
	iWVa6Eqk+EHerCwXk2uemF6nq7WcTntY8P8Jafw1Qf+8wQjIOrVJHO9XcJZei5UT
	Aamyaf9OG5Dy0Cvb8yPNMiz/27UgtmXNxWPPgvABQwFwGyAxlG+VGQGigFTRXw6p
	Y4BJu3X2F6Xyna0rt6BuJDIg1Xalsh11N70Lupms4u3bkw9VAI4i948T6Np98TnP
	EeVyQEINr6+lJybT6Mr0UhZFPhJXYcHioBA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsa1nt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:43:07 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5be0de8bf7cso259704e0c.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352587; x=1783957387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTSLcAtdK3ET0t7jfA4Z2GusLiBXn7g1inIdhOUoCy8=;
        b=c/XLZvSauefyoS+1ESukbiWKcH3+OdAIvIV9vTsSLWoW8FM16sOeAjWaawKFRJDldU
         iKwvp3Sm0yvvjYTZZP11cDIueiF8qTNDbb1UxJutguYgc15E3a6plf9GHAnKj0JhxQ+f
         8jS6j0IbnXp+C/ySQvteuXgRPe48cpVc19E4vvSiEmwOcuFIdZpzCUMe40cq1MiADxlH
         4osqve+LDjwo04ZEkBn76EQfh+GjudCWFaxSqTwSxw4OZ4MWnWEdq36zgtjKWy+xr0zC
         +9Cp+SBkrJ7nb09nkfTj3/ORrpgl5ssfWniitbEg0WbD/1KFpv7Bs7bR/kwZtClhHAaA
         NDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352587; x=1783957387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTSLcAtdK3ET0t7jfA4Z2GusLiBXn7g1inIdhOUoCy8=;
        b=pDFg/HcS02Fpabwd0I1O4rk+s6CqRUN403RMptNj05H11ovLziV8ig3LPN9P8CTpa5
         dYezEfvctOa3qFdb3keVKi0M/bjlFBLJgXdDzDd8xalIOA+CfxHnmphyAFrlxjw+buFi
         BxcN7v//utkL8MTFeVzyY6bGaIYeaqZ+NvfOn2te5kJMB08iOfjVbQFVVIcidhiZvjS3
         h9DhNcImBbE4Gj4nIBj1uxjrNz3zdw24ADvV4YxKwXcFnGvASF2YbAvkY6CSUP2f3gjR
         55efj+VQw7+dHytcCDQ9xhlouAdSENdXCnL891K3LSYbXEUV2qB61g/8899i8ZXhKWfx
         TnNw==
X-Gm-Message-State: AOJu0YyRLyzjXrzq2x8pje71yALZYZPC6sxb+Kis6BLW+qG8EiIJqYIX
	QXTuXd+3gzpt8sBWV4B8rw/PEU1jEWRa4F8nUpNnwzEuJD0nH/CodVLTY61t8eiupL7wTKG7omm
	gmMnebSD8+6nHoBwgPNFGtWXNkXFM/fv0QM6TSJAbt1doRHJiuSykMHN/2vUYa0H5bMHO/hQ=
X-Gm-Gg: AfdE7ckTixQH5Pm9JocUXBE7hf3bus4nNXEZqb+9+VASrYOZAzCwa3MZRXu+h5whZll
	IMmrlzcnTlL0mqkv4oXoUB+3CHuVC7q+SuGoEM+n8Za7MK0swT9MUQnfluGrC9uziRd1deN9q6l
	adxT6PIxpk2E0zW2L2U9zihamH6X1koNaS24on4tFXIBaHd90WufZFoGfXUwQ3wAOQv3Pp8gizN
	+GywvjI21dHJayPF8OchM5syPVTkjp8qZvSG1gOY2YnUVfaszw1GWEG67vPKTJwyCv9c6hsI/Mk
	X56CcNVNKXT8hIWxr4MsO/6R0DvTPDrgQJFeHNd5Ft+KJ/8qKQGvFQnx/2fGo3xITP1a+iAi20M
	B3sB8ziTP0CDuqsaWEzC28Apl/iN2zItUhd3MV3teJ0d1chuURZhXGfzJSNRNtuvbQd3r
X-Received: by 2002:a05:6122:6212:b0:5bf:4522:fca7 with SMTP id 71dfb90a1353d-5bf452340a6mr21472e0c.4.1783352587229;
        Mon, 06 Jul 2026 08:43:07 -0700 (PDT)
X-Received: by 2002:a05:6122:6212:b0:5bf:4522:fca7 with SMTP id 71dfb90a1353d-5bf452340a6mr21456e0c.4.1783352586801;
        Mon, 06 Jul 2026 08:43:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed136f913sm2915309e87.6.2026.07.06.08.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:43:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH] mmc-utils: Update maintainers email
Date: Mon,  6 Jul 2026 17:42:53 +0200
Message-ID: <20260706154253.125106-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OJccjGI6PIbEr9BTDl4Z2qfVrW2mZ9Kv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX5EHCd0l64gft
 MoPTRll2bkJ6o2XuUJer5cadNKbGVt8J8ohKj7U45H1QrFW4nxnqItu50+pd2T1Dn1JMNV/tTmS
 XXLvlj+Xl/sP3h4fIXq13UJypxC35oVIvZeD8dSzEVZh7Dbfze/498LpfAnWNwv+PhYUYBK1nvh
 MTTxZ+7iy9HHNMEaeTMuL2BBedWmExib0x5TqowmS+n8Aze/I0V24NaXoRAf2W2cahM7w7mh8x0
 PBQIc4r6BZutYND4uiLGZx1tezTkBEUV7VNz1qWD9/U1JSac52oQlornK5wBDkmC5eLf30VYlry
 I0A0rTv+5AkoaVybCk4Z0amt3g6hSzBo2sr/L+Ynf7gw5vYw60iPecN1LG3frKrIWWZhenX2JRR
 vB34sQ5nDy91SNCYmPFbVj5XZUJuHwsCRg/oh3Ra5gcv8BYVv0DwIgR3MVsxUqDboc08FetcRjS
 pIePXvayXD2N6j+S3xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX/ghoQXVT9zBq
 gKGlGTaceTFwuXN4azTphz/cBRlFa/qLch3+ll1x3YhLn1cTRnxzCORULAe6gFtrEZf+iCkB2fp
 gOYVGtntR/gKjdqk/Xd5BLXF+1McOQ0=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4bcd0b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=JF9118EUAAAA:8 a=KKAkSRfTAAAA:8 a=Op-mwl0xAAAA:8 a=femNf3zlAAAA:8
 a=z557s3kMW5iy2au9X7oA:9 a=tNoRWFLymzeba-QzToBc:22 a=xVlTc564ipvMDusKsbsT:22
 a=cvBusfyB2V15izCimMoJ:22 a=_kNtSFdpYmJUICABlfa3:22 a=Amtt_-f_ZOUBPvV6hmlI:22
X-Proofpoint-GUID: OJccjGI6PIbEr9BTDl4Z2qfVrW2mZ9Kv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

From: Ulf Hansson <ulfh@kernel.org>

I am no longer working for Linaro but have moved to Qualcomm. That said, I
will continue to help maintaining mmc-utils. Update my email to my
kernel.org alias to reflect this.

Signed-off-by: Ulf Hansson <ulfh@kernel.org>
---
 README          | 2 +-
 docs/README.rst | 2 +-
 mmc.1           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README b/README
index f18fcde..0c22710 100644
--- a/README
+++ b/README
@@ -27,7 +27,7 @@ Maintainers
 -----------
 
 Avri Altman <avri.altman@wdc.com>
-Ulf Hansson <ulf.hansson@linaro.org>
+Ulf Hansson <ulfh@kernel.org>
 
 License
 -------
diff --git a/docs/README.rst b/docs/README.rst
index 9606501..b1e3366 100644
--- a/docs/README.rst
+++ b/docs/README.rst
@@ -39,7 +39,7 @@ Maintainers
 -----------
 
 Avri Altman <avri.altman@wdc.com>
-Ulf Hansson <ulf.hansson@linaro.org>
+Ulf Hansson <ulfh@kernel.org>
 
 
 Building
diff --git a/mmc.1 b/mmc.1
index e4ac7bd..f0b3c80 100644
--- a/mmc.1
+++ b/mmc.1
@@ -363,7 +363,7 @@ $ mmc ffu IO4e0aC2056001801M1100042AE1.fluf /dev/mmcblk0 4096
 .B mmc-utils
 was written by Chris Ball <cjb@laptop.org> and <chris@printf.net>.
 .br
-It is currently maintained by Ulf Hansson <ulf.hansson@linaro.org>.
+It is currently maintained by Ulf Hansson <ulfh@kernel.org>.
 .SH "REPORTING BUGS"
 Report bugs to the \fBmmc\fR mailing list <linux-mmc@vger.kernel.org>.
 .SH "SEE ALSO"
-- 
2.43.0

