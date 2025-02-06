Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7C2417C0;
	Thu,  6 Feb 2025 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883006; cv=none; b=J9K4DFYZldbwVScageM35gFzquFnfcuqkR7oAsrXEBZPMtLqkeedCnhVI/+meBvYVMiJqF+yf8pxjIHCJPOirtWvXHfRVq2KJPqD5OUKT2DKbgENtaYdnnEEFHTSJhxwVF/EGyUC2j1QetbedaCSCDru4ykL4RFQKmqks0ktq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883006; c=relaxed/simple;
	bh=NlITSawW+DQyY3XY18sCOkBAch1CacQ0lSTqJ4cGwkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNkcL9o+EieVWjVOXw45F+Iunb1PDYCE8+ryPjxI6hKEIh8iF+fJ1Eom7P7Yn2N8+9atFzEuasILT3wNDxrKNEeq1xEZxOppWMNXyY9KJPI7IDt1nnhgpUR/0RjC8oStSvTVMqs6C3MQX24wAydEZj23jPQJEfzQ4HBkU1LehXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=oyWY7AGk; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="oyWY7AGk"
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516JfwLF016203;
	Thu, 6 Feb 2025 21:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=NlITSawW+DQyY3XY18sCOkBAch1CacQ0lSTqJ4cGwkQ=; b=oyWY7AGkQ3Gm
	7s9cB4+OlHvtkTzuP5ykUCKcYxRDP07gd4OyC4jqFCJFzaHB/KBBku/FsVC4RcHI
	PAHk0wLZmhaKRbhQixHJdkoc/Qvf3/+BCgbGJmhHF2TMP1A0wsQIrpCO3gEhMS6O
	j+BerJYi2dbjR6B+7yaeoZwQhJn7WC2Lq29PPFCM75pp/lz19Dw+294i6N3ych5x
	KfyuE/NnrR4kmEknR4Rzrd7K8ijIx7X4C6GZqOdnFfvrYKkS+QknYvg7qTUwYZ/W
	+nnWS2kP19EFUDivEAtDuJGgAhY5PwzNpht0xzQi1+rGRXsy6CH8pYQN/v70trqm
	WddNwrYtuA==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44n3fe0uma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 21:08:00 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 6 Feb 2025 15:07:59 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 6 Feb 2025 15:07:59 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <ulf.hansson@linaro.org>
CC: <erick.shepherd@ni.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <york.yang@csr.com>
Subject: RE: [RFC PATCH 1/2] mmc: Update sdhci tune function to return errors
Date: Thu, 6 Feb 2025 15:07:59 -0600
Message-ID: <20250206210759.2980489-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPDyKFoYfUBLLBh--Qhj0p5DFW36yOTo_dEAH7s4STvWzuK9fA@mail.gmail.com>
References: <CAPDyKFoYfUBLLBh--Qhj0p5DFW36yOTo_dEAH7s4STvWzuK9fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: H8mlLVAH0yprFrbyRf_I0wQnPritjK1D
X-Proofpoint-ORIG-GUID: H8mlLVAH0yprFrbyRf_I0wQnPritjK1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=460
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060167

Thank you for taking the time to review this. I'll resubmit the patch, pull=
 in Adrian,=0D
and move the new field to the mmc_card struct.=0D
=0D
Regards=0D
Erick=
