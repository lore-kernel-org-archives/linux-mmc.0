Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DCE17A2EC;
	Tue, 18 Feb 2025 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904118; cv=none; b=LilN+IFken5tw6RWGxw8ouBzWdw7lCgUALIOQm6eo1xsF0hRSGT1RAmnaApPVoqwiZGy1YUvUlO8Z/qkTchC/2nitoqAt7fkpGry4SD4fwyqzNhCR5a3SUeesOr0mkBD7i2rLGI3RIWNGEwEZpoIDDr/JxS5+iA+Qp2ojcP5Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904118; c=relaxed/simple;
	bh=FwQLvt0b0jjAMvDANZYeEGm1bNKJ+VufBs8kb0nglPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+fv/rTvlWe/f19MnfFi2yHrmFJxIKnVTdkTkD3JXqFrfvpb0+g0q8sHH50DMzhR1Rf74pHsLxdOlZp1kSdzD4lu0d5F46tdFrIJjlVSQDnCug/EkR1VMQU+uqA0plmKEEp9NNLEE+MbMaSo0D4G6AUA9Ts80o4trMrkg1wBf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com; spf=pass smtp.mailfrom=ni.com; dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b=rCnh3LIV; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ni.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ni.com header.i=@ni.com header.b="rCnh3LIV"
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IHVLRK039602;
	Tue, 18 Feb 2025 18:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS11142024;
	 bh=SZryNcz4hB8/2CgV3E5LWmJHzoiXcaur0GcsHqT1S9s=; b=rCnh3LIVz07a
	HLO5hcfbrI4Dl801Iz3A5H1cocSoSTDB1rLTV9oj28aZ1bqvNLZ5lV68hIG3HTI5
	PLzUi06QKh7GgcqfeGa2kcpS8tCiyl20ZuYjrmUzOB8rsbtk6WZ5oMuwcQfVqXAE
	Gz84O/8XRU35XdoLdsKMwo+9GtEz+85PLoqKdeyCqlJkU0fhOR2L0cf+mGe8mUuQ
	y0/4NRL8srSQHTfqZr2FOeh/b9qSUpDQQAPxb9EFNnpGs7j0WiAIJIGfrg1R9K86
	/kR5iabhAiU4BRDgiOBzVQI291uTI8TKdndFkjz7FjFphCdCWHf8SIMPbfNTz6Bo
	w38Ha0FXHg==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 44vxp9h43h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 18:41:13 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 18 Feb 2025 12:41:12 -0600
Received: from ershephe-ubuntu.amer.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 18 Feb 2025 12:41:12
 -0600
From: Erick Shepherd <erick.shepherd@ni.com>
To: <adrian.hunter@intel.com>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>, <cw9316.lee@samsung.com>,
        <dsimic@manjaro.org>, <erick.shepherd@ni.com>, <keita.aihara@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>, <ricardo@marliere.net>,
        <ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
        <wsa+renesas@sang-engineering.com>
Subject: Re: [RFC PATCH V2 1/2] mmc: Update sdhci tune function to return errors
Date: Tue, 18 Feb 2025 12:41:12 -0600
Message-ID: <20250218184112.574772-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8002f01b-97cd-4c30-b00c-c73d0cbccdc3@intel.com>
References: <8002f01b-97cd-4c30-b00c-c73d0cbccdc3@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: gQIfY5-fF7ovBVqH2DeT_Z-tWmElfCWK
X-Proofpoint-ORIG-GUID: gQIfY5-fF7ovBVqH2DeT_Z-tWmElfCWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_09,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=762 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180130

I see, in my case intel_execute_tuning() in sdhci-pci-core.c is what=0D
is calling into sdhci_execute_tuning() so I should check the value of=0D
tuning_err there and possibly return it? The issue I'm trying to solve=0D
is only for DDR50 cards that do not support tuning so I could=0D
conditionally return tuning_err if the timing mode is DDR50. Maybe=0D
something like this?=0D
=0D
---=0D
 drivers/mmc/host/sdhci-pci-core.c | 3 +++=0D
 1 file changed, 3 insertions(+)=0D
=0D
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci=
-core.c=0D
index 1f0bd723f011..9aedb476bd5d 100644=0D
--- a/drivers/mmc/host/sdhci-pci-core.c=0D
+++ b/drivers/mmc/host/sdhci-pci-core.c=0D
@@ -725,6 +725,9 @@ static int intel_execute_tuning(struct mmc_host *mmc, u=
32 opcode)=0D
 	if (err)=0D
 		return err;=0D
 =0D
+	if (host->tuning_err && mmc->ios.timing =3D=3D MMC_TIMING_UHS_DDR50)=0D
+		return host->tuning_err;=0D
+=0D
 	/*=0D
 	 * Tuning can leave the IP in an active state (Buffer Read Enable bit=0D
 	 * set) which prevents the entry to low power states (i.e. S0i3). Data=0D
-- =0D
=0D
Regards=0D
Erick=
