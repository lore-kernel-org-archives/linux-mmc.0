Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA9C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Dec 2021 06:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhLPGIo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Dec 2021 01:08:44 -0500
Received: from mail-bn7nam10on2110.outbound.protection.outlook.com ([40.107.92.110]:49249
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230346AbhLPGIo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Dec 2021 01:08:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDM0oFN+qi6Wp+8kSqcQ0SxKV5KUb9ZCQbp/KYl2TaPZw5islnqdmXOvmH3VvGnvt0TnIL67Y1dChIgIZsBOCDvcYauq26bbUJkoZnrn192KTWot7ukXb9pvNIRrf52RqB6CJNPon021mLge4euJqJADqRoR7VUu9tolxftxWAEQs4ZwiDX8/Me9gWMjll4th2Z9bknBUmO/YQUM2RysYhD9+3gum3PCvIJoyDQ+ZaeldyMNq/l4DFk7F9szfmuO+YCZNtsRe4CKyzRudtF+4DJFDw03Gx38A+GGUCNlLNomQUEdfkmsrSDvE4oBzyjJb8luvnbugGp82i8pR8g7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+6E+u+vDCJWVvwrUrdBvjReloiqh8Zrr6S3w0kfHEg=;
 b=OHFxX10CQE3+N7xJURDEoVL262lVfte8D/ME4KQlWIX+dXhl5jP368bqk/rc2YpLEimETVocTeXdutH2BELbyA9+LwWm4Un88YVucFtRAibKqdWnMzCzpZVo284IQnEUwinPVkFfothVUl/Wj+clATlbVwxncXFqNwkBn1s4+v5UfpCC+ociSvanxA2lY+wZEnHCyM5k+VszXEhsOLBXdUVRnv+TqXntFJTlZCxpA4XzmU8mFjilkmiMbEu/aErIVEvPhJ/rHDdL0nQk0/FHqE7C+XXq9kBg7DCInLw9WmL1NB4953OxDYKjbD3MxEcOyR5WoWIhxgAPmusECykdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+6E+u+vDCJWVvwrUrdBvjReloiqh8Zrr6S3w0kfHEg=;
 b=b6egVFLOUmfRUVb7844+yCpg6/MSsdkOghOvadb/2g4ouZhOyoIfD0gvv756s03wLkZ0FreKQToRhrJvP7qVb9iPBb6oR8rNo78g9Oi1DtDDja5SXxnw7yCds8kAOCj12mgtxBcNyGIIWpvPtM5lt5a31vO2SKdBMtSNkXULNMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by BL3PR16MB4556.namprd16.prod.outlook.com (2603:10b6:208:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 06:08:41 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::9597:403c:22ad:5479]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::9597:403c:22ad:5479%9]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 06:08:41 +0000
From:   fred <fred.ai@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Subject: [PATCH V3 2/2] mmc:sdhci-pci-o2micro:Make the SD clock's base clock frequency correctly according to different card mode
Date:   Wed, 15 Dec 2021 22:08:24 -0800
Message-Id: <20211216060824.357-2-fred.ai@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216060824.357-1-fred.ai@bayhubtech.com>
References: <20211216060824.357-1-fred.ai@bayhubtech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To BL3PR16MB4570.namprd16.prod.outlook.com
 (2603:10b6:208:349::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f703517-eafe-423e-efc9-08d9c05a81e5
X-MS-TrafficTypeDiagnostic: BL3PR16MB4556:EE_
X-Microsoft-Antispam-PRVS: <BL3PR16MB4556FE3E3DCB81F65962EA1099779@BL3PR16MB4556.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8O7BGIxuuBICJD4HbiVjAyLR1K5k+7w0PS1T1Dw4DkUP/R8RZhlJQUhPvi4ND8dpWDxeVCJ2oqrOmzWNLAPL8dsTQ0I95w8QY9Lge1iwMnDH4Ih28LJjCfdLY28FdogwJAKL/EJBS4ZwIOsMn+osyRLHyzx++2gUkRBlF30sa1us0LOX9LN2J6irwMn7lAbadcriU656PIfVY8JWWxk2yjMdKHY5XU8L9OXbcIvKGXs9RyRFeIrjx+3X4tWqIq7B8R7+OZUWr3an0bUJuI+sU/miivSum8FezFniHBjPfxKlvpg4W87UYK4psMOfRRfWne3ooHp+mIEd1ThgAL4VYuqBZNej1S8RgJtLapH1VO8E8+QTe8r+fHv8pVxXMqhfLj1aV3S4e4o6N6ijIkzFz629Bg/c0jGTpGJKZiOW3rd9UuHf6MwPsLVZ4I+ZpNisytGyv2WlPmBwbjEIi1+IcfcZPZfrHEVRKR8MN2acpQb4huB0WRYANENB9cHnV1Oa7TXILIgD1zFhm2V8r012Qu6qsNhC7VOQ9LsxrZeOgM5TGP9/PNBb/WsmKJy4r8KJeW9af6I+SB/9+dH7HM73kuC+mp4jQRIznFN8L7nHgnQ5z9/dFQQMGPcBs4VFqkMdHgLwUwTkFcm6DH4zWVRfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39830400003)(376002)(366004)(316002)(186003)(38100700002)(2906002)(8936002)(1076003)(508600001)(107886003)(66946007)(8676002)(83380400001)(66476007)(66556008)(52116002)(36756003)(4326008)(6666004)(5660300002)(6486002)(2616005)(6512007)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dS584o4tmW2SNzycjcsS+Xzqy6TK+Bl5rEHGn+5fchv7At8avSfOqtTU+yyW?=
 =?us-ascii?Q?p10wnZboj29fmOwETsgnlNmbQDE+lqSdUuNeGbvDzmA7N+6jEmsgTlqnH/HV?=
 =?us-ascii?Q?F4zWHjP7AHVIdSiYFYX7QfTr+JquKuNKnDHHQmZTG9lMNjARCzbwc7OG5UcY?=
 =?us-ascii?Q?Q3d4XjrXabCvBQwNoVDEQYJsnbH1U5RKcciyP7FvhUsZb+FTPJVeemCVx8DS?=
 =?us-ascii?Q?giJhgdukM6sHWJbxe44gj7znWi1Wo8YdTeGODxcN8U36IOe3sm/9MhGLJAkn?=
 =?us-ascii?Q?wJaQNNgfSwO44qhopj6XoIkq+Mlub4UrYK5wQ3ubAl+0Wve5tkW7lCuK8qpx?=
 =?us-ascii?Q?98OzpNa+Ri75GKAGISiqRTGTRgx9Y0y8JqzIH+HJT4rGKwar80k829QMX1Cz?=
 =?us-ascii?Q?c+vW8maH5oVu41OctHmSY7M7F/dZxVvuAoQ0IgGL/1Rpm3bRAzVV3w3SSMdL?=
 =?us-ascii?Q?wj7O0DuTf8kXlIbJdpN05khcHfmFiA+X76nWtJy2Q0yUKUoMSIcNczqn2r0b?=
 =?us-ascii?Q?MurcGNM/bbm4zxzX9tzeFZk4aaNGwrQtXvYCLfE+pN01LlTFAObAKjQzSFty?=
 =?us-ascii?Q?QhXKowqzASfSEn+nk042xa4PBccbsYgtes0XJaXvlKaRB+xqwabp05Mu+ghd?=
 =?us-ascii?Q?vEVwhWy8PAFZuvI0dt2J2x16NhmlmaKWbP3j4g24X1Oy9pMZ2urTSFRJCxa5?=
 =?us-ascii?Q?OciY/ss9exhVNm0tQhiBFBOs/PA7sVZ47Nwun7c+9j4rI2ZXPG6rCIMGWeLj?=
 =?us-ascii?Q?VQSnL19+56lJ1OHeVxrXQv47G1RLj9DzM0KHNt3W9hmId213YHy/2kdyN449?=
 =?us-ascii?Q?74g8IdqgJuqezmx9a3F4F0f/3UuDriF+zA4+ZivCmwXyHtvft4difnlWOLtq?=
 =?us-ascii?Q?5qM3xL4d4Z5DWVBv7Y8lc7VfaQYEyoCrpV3rB0/8V8oGPHNJdNCS/rNo3QgX?=
 =?us-ascii?Q?Hwhy+g2aGXGo0eYE3KROdYm+PIZiGTic1yhMr3C3mSHZNjsOGYJLuIx9VFDM?=
 =?us-ascii?Q?WlqaSRHkkM5jD9i/bR/nRNHcLwiD360U2ydJebcC0BzISX4cg9xYQ2wd8Lu1?=
 =?us-ascii?Q?f6fd4qa/XwZh5WeTKN8ldlgZ+F7petJMq7U0STccaMQlOtYUumeodDjqAf0K?=
 =?us-ascii?Q?uJGEr8glv51poZh0SdsSpbzrrPUzr0dnyYmL2aSkZ+q/dwj2HM7BSALcH9lk?=
 =?us-ascii?Q?Ywl1pIhJ3b2D3Im7iFCH/z0cF43De+zhJTlXPwZiEnr4AJ1KAGOAO7whvMIT?=
 =?us-ascii?Q?M11G0kgG+NAjMAMYjr9krRKu6o4mxpjrhwkv8BhU3/f5cTDIFUkV8vGcIXZU?=
 =?us-ascii?Q?tjiDtssimp34l8l6G58wiKPbK8ClsEPG7ftVnV8GZs8xQonpy2sROgQXDMsA?=
 =?us-ascii?Q?WTJi9vdZAhJq+ilXwHvslorosD43K2Kv7qMNXlRtXR/gqzZznh9XQzJbhEDO?=
 =?us-ascii?Q?201PUubaiUYNfv4VVloY8OdIp3moO0ele/0ZQ1hVcEv6UcUVDRQNu2AugmX9?=
 =?us-ascii?Q?F9kafX3OJTXpVqm+pIxS7+yiq86jUlXZC3aXkP2x7VcQMknSkQLCxBVDvdOx?=
 =?us-ascii?Q?AaCCAi70B8hLniYsptEgNGIBmVSpPcTHTauqgk7q/qgMZ8XC4DZG9Q1jcJcA?=
 =?us-ascii?Q?Kr7wa3L7RElEEiLU+wsb6rmAdWeG/3+4IlAW/3CEOtA291P4fB+4gAih431v?=
 =?us-ascii?Q?kKIOTRJCIRQDFFtEQ6uP70EOjlU=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f703517-eafe-423e-efc9-08d9c05a81e5
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 06:08:41.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+Dmx2qjPJqNjtCfBhpk8LqdnGr9gVd3mgl6baFVEpT3dtbx1EJUUEPMUyvOVuMptfJx3BnyQSVeVnSXW3KDnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR16MB4556
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Fred Ai <fred.ai@bayhubtech.com>

Remove SDR104 card, SD clock's base clock
frequency is not right when insert SD2.0/SDR50 card

Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>
---
Change in V3:
1.Set SD clock's base clock frequency to 208MHz when card mode is SDR104/HS200.
2.Set SD clock's base clock frequency to 200MHz when card mode is SD2.0/SDR50.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index f55602609f8c..4ca1e8c5b631 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -577,6 +577,11 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 
 		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
 			o2_pci_set_baseclk(chip, 0x2c280000);
+	} else {
+		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
+
+		if ((scratch_32 & 0xFFFF0000) != 0x25100000)
+			o2_pci_set_baseclk(chip, 0x25100000);
 	}
 
 	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
-- 
2.32.0

