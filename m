Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0436C;
	Tue, 26 Nov 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625457; cv=none; b=gfpe4kNVFdFz8LlUweE478OVIUc1g4ecHo3JJhvq91KDtvRmxLB0cz0RWDWB8W+4Z/nsjuaI2BZ4YV4Y/gDi3PAQU4tvVIZsugnBpypsfzDQ0OlB8WvtSXmZnU8iczuTlfL8yy74rLpVNHVoiHooi85FRr5n4L47bN/bM2S524Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625457; c=relaxed/simple;
	bh=1IOZP8hVXzoTsOyuc9uOdk9ukNBErgXzh0dS7l0vY0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t2jClzmNwUHvNNp0cMgKqmMqK6FV+MW2nCZh0GX4/miQSGedzc46CaSBxox+G7UNjVJDs8heI8FuXXiDHmsHclBLdRPq+ga97yQau9Wvq4JVVE0HCoJlnlq+u4oOYxjqsi+157Hi0t7P53vd2jVCeYxw0Nt1W1j4H9qX7+I/Tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GAF+8W9C; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GAF+8W9C"
X-UUID: 0f911c10abf511ef99858b75a2457dd9-20241126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zR28T4HcO7uRDu1sJWB1JUuBH1e3vmJiErnnGI44bIU=;
	b=GAF+8W9C+XwHpXMEbeMigRrwTGRbIu6Fmwb8J+ygPpGbhznMfXre6+JrpcH3C62uAs7btuHsujXE9vvC4TD3gXA3h220B2DPi3svWsej9RvwVIl2FL/ixNMyXYVTjEcVJ3nlvBqR6gqmtBlOYFFmdobOusasEAta7auNId+VGn0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:fbde0da0-1fe1-4b25-aa8a-97664b4ed414,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:ad274ee0-1fe5-4c4a-bdf3-d07f9790da32,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 0f911c10abf511ef99858b75a2457dd9-20241126
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 34843188; Tue, 26 Nov 2024 20:50:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Nov 2024 20:50:45 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Nov 2024 20:50:45 +0800
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
To: <ulf.hansson@linaro.org>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <avri.altman@wdc.com>, <adrian.hunter@intel.com>,
	<wenbin.mei@mediatek.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v2 0/2] Add mtk-sd support for ignoring cmd response CRC
Date: Tue, 26 Nov 2024 20:48:21 +0800
Message-ID: <20241126125041.16071-1-andy-ld.lu@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.889200-8.000000
X-TMASE-MatchedRID: d+baqQ3qUqc9S3IiQd+eNbmR+C0l9vjVc3ewuwbSaG4Y0A95tjAn+9TT
	TFFPxHv+u2t1gv/FTZu+gPhGSQqXaXAvdl/gU+kWhK8o4aoss8pKPIx+MJF9o5soi2XrUn/J8m+
	hzBStansUGm4zriL0oQtuKBGekqUpnH7sbImOEBRDozr28CiiojKTexvwXZBrsmqd7uJXrWO/Ml
	oQ6zIAH/Cy9GvqHOwrPyjHI+FEw3HHHuNqhV1uRVgwOoJTNhLaqeqo7KB4WGHyNp7g4PXe0BXsx
	z6ujBxUq1f8XSkHBUmNJXmEMVvLtpRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.889200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	31A115BA487A2D1BB3781A4ED6205A89D2BD525579309D2E70C160360EDFE3AB2000:8

Add the process flow in the host driver to handle the R1B cmd response
type with ignoring CRC, which comes from mmc_cqe_recovery() in the mmc
core. Additionally, the response type 'MMC_RSP_R1B_NO_CRC' is introduced
to simplify code.

---
Changes in v2:
- Change mmc_cqe_recovery() to use MMC_RSP_R1B_NO_CRC response type.
- Remove MMC_RSP_R1_NO_CRC in the host driver after it is dropped.

Link to v1:
https://patchwork.kernel.org/patch/13883787

---
Andy-ld Lu (2):
  mmc: core: Introduce the MMC_RSP_R1B_NO_CRC response
  mmc: mtk-sd: Add support for ignoring cmd response CRC

 drivers/mmc/core/core.c   | 6 ++----
 drivers/mmc/host/mtk-sd.c | 6 ++++--
 include/linux/mmc/core.h  | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.46.0

