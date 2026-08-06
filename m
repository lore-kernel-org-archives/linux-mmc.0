Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8146D55F
	for <linux-mmc@vger.kernel.org>; Thu,  6 Aug 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017095; cv=none; b=dZnwu+sy4EeWSVaCWYXY17ZV4JcSbQO+hbs78t/tLvM5e6Zop59CgVX2jf2iR2Geb5q3swusuEHYeXAALY7D3uiO48aLzDWNDNNejI3qJXgIPDETRrICeE/wQ0wn7o/UQvdYnls6ZAmdSJqjSskqjLIB5Gvbz+P8pQ6FNzKH66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017095; c=relaxed/simple;
	bh=mOF6hIpZ8JeVEKVTQkQ9yXlKw1+DteSY4iKJyljW7G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmU1icCRRiUJ/cpxAyX9DyQsJgYBczo7WV8HuyQrpQQvkMcL1MNdwO0lEODl5KUUAhDBx5cG2CCitvEho+syPsAX9+kt04jHTrQpvFL8xgKeuSzVLnEmIJONorjdQ4N4wQ4WYVxsFdb+LBW2rQkFB7cYovwVA/OcNlPGOIeJlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G4WudNHA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WolRNM1L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G4WudNHA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WolRNM1L"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nmkr2724774
	for <linux-mmc@vger.kernel.org>; Thu, 6 Aug 2026 11:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=OPYnIgXcA7ye546oDj6NyY/eDr84I79POHr
	f4C0NnBE=; b=G4WudNHA6qmudCP67FAX9PtJLt9+GsyuqI6rJvTkVLCdkHefc+3
	oi7Z2UP+xEvyIH0gv6WrbjFN87NCRO8oBkqd2pH9eAoaxULEHYmiVXkB3PKllZzD
	2QqjmwaXF4hWAJCnN9neiV1vN+oF2CWTGl6luyxZuL7zMlHqSlPymfl8i+KUBpxp
	JL5VeWDrLnG3hrfy+AclySnyejyQ9vfgWVKZFLHPgOvmbf9q9cYc81nAIVjUNG8K
	97H9C6yZ+R+d2hlrY9pHd9DkvItVFEXuQOFAIZXInsIMeOAVnz7nt6ysD6RCCLl7
	1CFXK/+/Nau3FbYdY94io+/vi1y9qGIa0nw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9dmm5fk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 11:51:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c26012cd0so20423771cf.0
        for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786017088; x=1786621888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OPYnIgXcA7ye546oDj6NyY/eDr84I79POHrf4C0NnBE=;
        b=WolRNM1LI1WW/muBUdNp+Ec+Z8P8pnMLFThgsjN0CXILxWcmPauYEnGZqTgezPDue9
         qVMD4rK9a3AOZm1kCVGJ34MfIO7vwgUWNvzK5p4Ntt3QSnz7X9z14/4c6+k4tSth+OIQ
         8ft0+68DRVTIrmUAUUHZefjMNoWfrsfV7/AOE8fkiLN+JLyVpH1Yu04peaEwgPhW/zLH
         o2scOj2Ca4xamedFBYMbWihbmlW8x5kDqTH72RWqAdKkpNwgIJvEUuA5lU1TpF07D7VK
         Xa4/sQhuoPnvTBUPR9KnN9BiiZIES43oMvi5BARbybzQB7C1anEHoyBneYcyw88rCptp
         AsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786017088; x=1786621888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OPYnIgXcA7ye546oDj6NyY/eDr84I79POHrf4C0NnBE=;
        b=i2ZcTGaXYE4qGsgOdq+1uWt9dEHyJOb+QlUfWcNAlEg5hAGw8Vf/K71Z1e40eKAqlz
         C2SNMLXHkN9bdRmksxs++pxL9B5pq5t/jjc0djIcXuaVrxCsK892qk3nM4zFS3i5kl7N
         7FCM1cLTc7V+2znewOifM4GL7qlk9xnmet7zbxk3midALn1JklOYNYvFRIF5SnWBZOdG
         0MZIcVJdU/awocz8rmVbUNlpiPglCLVboooM/Arsx4U+hDNKaYZCi3c2HHW4Dku1Gv8P
         K448lofmWAedVOR9ZMSNdQlHmmrMmHUzOScBwzNaEjOQi0JBdyW9ScyIW6b3Wx/En/oU
         /WqQ==
X-Gm-Message-State: AOJu0Yw5zT6at/mpK9Reo416KzRAsZOaaPEqzMCeLwbG7qZe2a9Tvoiz
	M7ke1Yp0sc2hnondQx4k/2SCVghEfvvFfJaBEl2iVxiinBab7IMNoQWGmafl4XB9sNd7baH1aRh
	+Cx4lsusGjCgIciu4CC5utDRfUIAsN/4ZEKGJRRfSAIxa7Mqn97LGF2SQlEsC3QqicZodps4=
X-Gm-Gg: AR+sD12uPRU4Vm3mqw9YV2rYftid/pIGlk2RsKIO1vlTgzne233D97s22R+6IQ5x+7h
	dzvHdpvCrYqRECbyI2UvAZ8OniXj5WMO2RnVbhmEtkmRh0MLVmdSgwPI0zvpmBeWvKljCKZol0G
	vNiTWVQID3tqresUhP0QF6jajmVSHC2X0Cp2DrLCvVLd4WLpPYB5clIteSEXzEb3RVc9VECfp4W
	RD3jhVIPKYAWZc9JkMXF8cwp4U9PgWRRgaa8QzxCGFoR4KJwbOFcCGs/3qJn9OMAuIVupZLRNH1
	s9vjd2FGWA6BScGvWpdUbnwPuZwUK/Cj0SKfdIMXTCNtM97jSCBDgOeReXIiKC/gU6dMw62I6ht
	aaF13prOwTz/tBu+2vdlYcgL1gf6JUYuudjZmBq7zifHpQsmCn18MbTi+jw==
X-Received: by 2002:a05:622a:180d:b0:51c:478:32a1 with SMTP id d75a77b69052e-52ce5ff2f53mr139723221cf.18.1786017088454;
        Thu, 06 Aug 2026 04:51:28 -0700 (PDT)
X-Received: by 2002:a05:622a:180d:b0:51c:478:32a1 with SMTP id d75a77b69052e-52ce5ff2f53mr139722691cf.18.1786017087895;
        Thu, 06 Aug 2026 04:51:27 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1942008e5sm751945a12.1.2026.08.06.04.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:51:27 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>,
        Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH] ARM: PXA: Fix build error for PXA93x
Date: Thu,  6 Aug 2026 13:51:12 +0200
Message-ID: <20260806115112.45821-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJR1jVla c=1 sm=1 tr=0 ts=6a747545 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=XQIjbqt0cXQhyFH8yRMA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: zUWx_YRixxe2E4bESGs0eCqZ3IAW6CSG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5MyBTYWx0ZWRfXw8asrD+EBgBf
 MzIyf/AG9CMoPF5kVM/eONe2Hsma8Fy5FQ2HeHW5hq7m/86SZSRpZuVpEENbvM9u14Cyft9BHUP
 diVuOyUxRNkbs4VgS1OodXfolYYtYDs=
X-Proofpoint-ORIG-GUID: zUWx_YRixxe2E4bESGs0eCqZ3IAW6CSG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5MyBTYWx0ZWRfX+/JktS+kge0t
 ij2HCvKx3mAscEJ0PH3sfyzVBCDKEQcBTJ0GEYY2oDm9PRqxlio2xgrjJ/5NSu6lQ5XkJoVtLIK
 v6t8FdiX4RnD3+5qHkLIySVGdGsXeAICx/++v7f1aNBjx+3NnSPihQWb6giSFsCd8HBYBTbjHBE
 uYGnlSjVKyn0nyt1GhdtkcSMY4+yexqzde9ULMw+sU7jF6x0SgzzTC6uc7VIijChqEk+7yG4nsj
 i++HCDWMk2ZFDnqS5fogyTBY7UGhCNcuYjpRMIqHBZKWIQ9bLNJPE11jPu6+5kMhgxEazOhy3tr
 orKqjgoQ3jZvLZi4i7j+1I60CYfuvvmUbYaVxfDkjUt++Gs9ZKtRmQmLHZIfgQUGcJuMTVAc3AA
 qrrBOPfp+RaHs08zhp6olJyb/XkrrUh+AGS9DICyW9cKSbF4t4PEARPQajtPhuUcHeLzidLwVu2
 2gBh7N2WMRCR4j2rceA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060093

From: Ulf Hansson <ulfh@kernel.org>

Add a missing semicolon to fix the build error for PXA93x.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607301822.cl0lEkQt-lkp@intel.com/
Fixes: ab9c44bbf6d7 ("ARM: PXA: remove remnants of PXA93x support")
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
---
 include/linux/soc/pxa/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soc/pxa/cpu.h b/include/linux/soc/pxa/cpu.h
index 38bacdae684f..c5b275a80854 100644
--- a/include/linux/soc/pxa/cpu.h
+++ b/include/linux/soc/pxa/cpu.h
@@ -177,7 +177,7 @@
 	({						\
 		__cpu_is_pxa300(id)			\
 			|| __cpu_is_pxa310(id)		\
-			|| __cpu_is_pxa320(id)		\
+			|| __cpu_is_pxa320(id);		\
 	 })
 #else
 #define __cpu_is_pxa3xx(id)	(0)
-- 
2.43.0

