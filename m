Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A7110CA;
	Thu,  7 Dec 2023 19:22:14 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B83LpdN6576387, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B83LpdN6576387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Dec 2023 11:21:51 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 8 Dec 2023 11:21:51 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Fri, 8 Dec
 2023 11:21:50 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <frank.li@vivo.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-mmc@vger.kernel.org>
CC: <ricky_wu@realtek.com>
Subject: [PATCH v7 0/3] Support new card reader rts5264
Date: Fri, 8 Dec 2023 11:21:42 +0800
Message-ID: <20231208032145.2143580-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Summary
=======
This series adds to support New card reader rts5264
patch#1 
Going to have new files to define rts5264 funtions, 
and rts5264 register definition
patch#2 
Add rts5264 to rtsx_pcr driver
patch#3   
This new reader rts5264 can support sd express card
so need add the id to ths sd_init flow of rtsx_sdmmc  

Patch structure
===============
v6->v7:
move modifications of rtsx_pci.h to patch#1

v5->v6:
add more description for individual patches  

v4->v5:
add summary for this series

v3->v4:
split new definition part up from same patch 

v2->v3:
split misc part and mmc part

v1->v2:
remove ic version check for rts5264

Ricky Wu(3):
 misc: rtsx: add to support new card reader rts5264 new
 definition and function
 misc: rtsx: add to support new card reader rts5264
 mmc: rtsx: add rts5264 to support sd express card

 drivers/misc/cardreader/Makefile   |   2 +-
 drivers/misc/cardreader/rts5264.c  | 886 +++++++++++++++++++++++++++++
 drivers/misc/cardreader/rts5264.h  | 278 +++++++++
 drivers/misc/cardreader/rtsx_pcr.c |  30 +-
 drivers/misc/cardreader/rtsx_pcr.h |   1 +
 drivers/mmc/host/rtsx_pci_sdmmc.c  |  17 +-
 include/linux/rtsx_pci.h           |   8 +
 7 files changed, 1215 insertions(+), 7 deletions(-)
 create mode 100644 drivers/misc/cardreader/rts5264.c
 create mode 100644 drivers/misc/cardreader/rts5264.h


-- 
2.25.1
