Received: from mx0a-00617f01.pphosted.com (mx0a-00617f01.pphosted.com [205.220.165.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7D264612
	for <linux-mmc@vger.kernel.org>; Wed,  7 Oct 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354086; cv=none; b=eGMi/dUzGXvSop3v+ihg702o6+k7IhYJ/oqCgCQKblRvxksUzez9puXgC7FcifrpHuMj8oD9lpBlXLMCN6N0XPHLjVlxM5dBIyytUV9Q/hAZKgKp9oa/XZXIz71r8gFNMXnHYPJo/bJbS7ziBig1EKhfFWfPWcDgy3Qc8FzBbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354086; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+RTDJhmZfVYIFP1tsZhtagPOpk/iltyIh0U2Y3ft2mbLGpAvLvtw6vlOyKsRXcRz3q09OvIPLrFOPB4xdvCfQbZ0Pwhv/alYvgafmTWhDX/sxYMdzql3HdkwbfoT1iEKvABmQvaT97NYfEz6KuZ3TtRG9yb1wj6sj5rae1t8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com; spf=pass smtp.mailfrom=psmicorp.com; arc=none smtp.client-ip=205.220.165.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psmicorp.com
Received: from pps.filterd (m0247527.ppops.net [127.0.0.1])
	by mx0a-00617f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697003l33310017
	for <linux-mmc@vger.kernel.org>; Tue, 6 Oct 2026 20:07:57 -0400
Received: from egc-exch2.psmicorp.com (webmail.psmicorp.com [38.142.134.66] (may be forged))
	by mx0a-00617f01.pphosted.com (PPS) with ESMTPS id 4h5b5e00nv-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 06 Oct 2026 20:07:57 -0400 (EDT)
Received: from EGC-EXCH2.psmicorp.com (10.1.1.111) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 6 Oct
 2026 17:55:51 -0400
Received: from psmicorp.com (10.1.1.107) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.2507.61 via Frontend
 Transport; Tue, 6 Oct 2026 17:55:50 -0400
Reply-To: <greg@gospelmusicuniversity.com>
From: Evans Thomas <_us@psmicorp.com>
To: <linux-mmc@vger.kernel.org>
Subject: fund transfer opportunity,Reply..
Date: Tue, 6 Oct 2026 23:55:47 +0200
Message-ID: <20261006235547.E72DF37802C7FBA1@psmicorp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 3H8PiSNJ6iBsbUr74N29ZtrjSW24fcCT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX9YxjcgcfojGB
 zhCrIr9HruCLnG1d/paL7YAbSC2367b8nNFN3yDb45B4E1IbJkK9o3Jaxh7jwI37gHkW8b99Sg7
 Ieow2hZzpsJE+c8EEiXhbBEGuIrgURVi29r3W78/GndXlIQqFcjFuyl2K6xCkgcbYmdqD3lql+C
 JJU+JZaZLZQstAWFWurt4B8pQ+lTKODt65PKJ0HJ0e+oCw8ZUPl0vTrIfkknIzZ8u1Cr4Kr2PKd
 HalAQHWbsV4nFmIfKj2uigzSm5GseDaC0Ditmp6G7V18OLeooAVi+T4xHjkO5VFqudWF8swVgoX
 Eau60JH+4Or5M6cTUxXGDGVvC5nWsJfGAUdJsMKypSRv7ibUKiCNjT+hEDxzV0skV2mEKCSNelb
 WlYsssdW3dOJIWmEnmI48DG6nNB6oD83o+kQF8EsxegNYqAVRAkzcU9n1+bGgyLJcY3mve0SogQ
 Xv6D87q3llhMa7H+YwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX7UErRRg8+DaZ
 jSLZZJ1N2rmvV79XPBHdk7POyrlvrPh450Yxg3JjZSEfhlJl1USz2rvRATgtS6FVtWuaX0EHi0q
 c8XEFVQBMrwThLeuCrr0xm+MSQAwEb49GQoCyWm0mwQkmPEBnn+0
X-Authority-Analysis: v=2.4 cv=GvTXaU1C c=1 sm=1 tr=0 ts=6ac58d5d cx=c_pps
 a=sNj4pI0fii9qGHoVqNzRVg==:117 a=sNj4pI0fii9qGHoVqNzRVg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ZHGAjPH774soz-f4Le74:22
 a=GfZueQGhKz3ujf-POmTq:22 a=tclcd6dtLQvEqt9_mmAA:9
X-Proofpoint-ORIG-GUID: 3H8PiSNJ6iBsbUr74N29ZtrjSW24fcCT
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070000

