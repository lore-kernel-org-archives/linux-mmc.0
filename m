Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAA1A23BD;
	Tue, 22 Jul 2025 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220104; cv=none; b=um6TFm5YYjnKwqN9ObR0ZEMrt35497bTFauiZBwy6/2t3sx3qcRkXoBg7VZ67lRg1OLHurQ0J+BOoG0F4yuG+5Of78QMHjqNGD+ACi9vcjXqb6bOBysJ0Luo3woPujVCMErJWcJ1Ls8K75OqAE4cEs9yS+X5LrYrQtkkjqj/DU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220104; c=relaxed/simple;
	bh=Q7WKBx1tqdlQE+NS8RbTg/KXkJpYxtnk2+HZyFxhSX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCBWy/bT2rKEdrC7BF0DlRMUI+cXtodUuuTFWkpr1cN7YZ8sYsuv1MKPvISxXym9cUIF5qOAkbWJd5mwNOYLjF0s9d9Av6ompnorCNX6brCAfBFB0iyoWNHgo2JqyEDx7PZ2hywIclfnF5Rt6ndVvP7Ovbri68coEzhEr/kVyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=r/VT7inS; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="r/VT7inS"
Received: from pps.filterd (m0484887.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MDoWHJ001676;
	Tue, 22 Jul 2025 21:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=Q7WKBx1tqdlQE+NS8RbTg/KXkJpYxtnk2+HZyFxhSX4=; b=r/VT7inSjPvs
	rnaeox26DqDoO12bj3PPZVXLp/ctDRHuQHwUS8f6cV5Sl7d/WAkVJamiwQIwKrvJ
	C9XslrD8AVKXDE/bfj8RAppji2CMewgS2zxD1pmX8EXFTNwat40e+7qD2Ef+pQc0
	2HbugiqbB6yCKCP/ILqawEbHWCJC4D1GStkEZwTfV7JjqOUNBHi8NapzNUWcrF+P
	KSX0QTcNXxCmvbEWu7wfRB7Q8KvTxuJTemg7wEkO5id1Eh1FvZDOEHZxO7B0WkGN
	oGQSLp75EswoJmQLGhXC72ykr3ojcYHAInShwWqOtT7EAw0RxBsfBmanodK881rU
	cXFtpIEf5A==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4827gs5jue-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 21:29:32 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 22 Jul 2025 16:29:21 -0500
Received: from ershephe-ubuntu.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 22 Jul 2025 16:29:21
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <brad.mouring@ni.com>, <erick.shepherd@ni.com>,
        <gratian.crisan@emerson.com>, <kyle.roeschley@ni.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <net147@gmail.com>, <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Disable SD card clock before changing parameters
Date: Tue, 22 Jul 2025 16:29:21 -0500
Message-ID: <20250722212921.679197-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6366c08b-1746-4d42-8f2e-af0b27766dbf@intel.com>
References: <6366c08b-1746-4d42-8f2e-af0b27766dbf@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE4NiBTYWx0ZWRfXzOI2COnO6vnp SJINaiGGnBf8FRNh6h7a8FI6NoV30MSMkS66rqEgFE9qk5iOQKKBX01Dv0GyueEmWQvjlkHHn5v NU8twlPYRS6eOpO5V3x8uncNdU/+6MrHGUwSCSS9ALwblSQ81UQoW7pzt3fjsTqL9clBV0BCa6g
 nNE0fkFcT/I5AmvPOkK0PK4rH0q3B9Nm/oJ7v+Oq7uCorU1LKsb1SadNMu59hMkimpxoZ809EAD Da4Ivoh9YlV0uuqjYgjXR4+mWUuo1txtUrl59+8LdC4mq6JyU+yWO8/Di5tRKKLdutylyIs43pS od3Qjibi6RT3exzFQPf7zhXv5EOC+Nt6Svz3MAwPejsKimbTnKccx+qRnmhH1Q/BZLgNsfux8/C
 R6zdZUyMT5jbdQurPAQyxJmAJAsWWJNIOeE/LlkwG51T/pH2nDcwn+T+eejpuIgqdGDuHsK0
X-Proofpoint-ORIG-GUID: 4FWvImgYzSvkxMgvCqi-6WkQcZOd4Xts
X-Authority-Analysis: v=2.4 cv=S7/ZwJsP c=1 sm=1 tr=0 ts=688002bc cx=c_pps a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17 a=Wb1JkmetP80A:10 a=nbBAGjBiGKU3lhzuG0kA:9 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: 4FWvImgYzSvkxMgvCqi-6WkQcZOd4Xts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_03,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=503
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220186

Hi Adrian,=0D
=0D
I believe this fix would work since it looks like it keeps the=0D
functionality of the previous change but only for intel SD=0D
controllers. I also tested your proposed change on one of our devices=0D
with a Baytrail SD controller and a Swissbit SD card and did not run=0D
into any issues.=0D
=0D
Regards,=0D
Erick=0D
