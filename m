Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9680C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 09:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AAD64ED0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 09:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhCKJmN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 04:42:13 -0500
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:61025
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231985AbhCKJmF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Mar 2021 04:42:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki37+HDXQK2Jyo5rD3D/SKXsWeI7Ii839TOJHxJ9hiBmXOiXB13c/52UxbCTwIR6b+JePTe2eE2F2l1HLkiNIkPTp6p/Rgb2k39WzcCcajDujO+bVLdGxplu2G+9IUuU2Hj+zCq0oX+ME2usOaLU58t62euulUzEFy68vFDc0bfbQmxZ3md1b6j5kRpt1Ai4fFydYUw8p+H9SqD9HDhHEfZUpx8KfhsuSzN4b7EAyzgLv1VOgjgDhMyahkOlH8LY2/4/Fc+6i6P35ckunWJsq7fiRs30zV87bXy6XFUKt+IAqYZKyVr7JQlhla13RnA3jLpEyYq0YMqO41D8GAuKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMLu9vWLxx1hPGOtWgObRHCmCpbi2Mow3fHrYkD6Raw=;
 b=baIsB/Hv9L9b1TcNvXcBZm1igsq6BeOJbNUkV/XTxdZPXl3ESXbhnOzhGDDNhcWOdBliE13k5erVeV+dwLG2FTH/SJ58KMfx5r5kni9vL8enJhcuou/kk2NTtJ0Ue9zNtP0dqkU9O4j/5GOE4zuodmSZw3AkfAWoKLyZsl2qpFiK3y1Poqh68mZIrgl1FjkE7fibQ0e6hoOMArOUPEhdopn50oG61O+zkpGR/l+WyE42wroITbfIPk1oz2dPTMlLmbkjUz+KtGyxAmM/E0dHJSBkvPC+jOEksZfCDTZnwnp4/XIUWUyWn7nVIJsDDszugo+SDxjvWIBtXfN6zbbs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMLu9vWLxx1hPGOtWgObRHCmCpbi2Mow3fHrYkD6Raw=;
 b=TIjzBxajYsNUYMAZDbTGiI30Y/THOmMj3hhTz4f1bhhTRpPqxvzztokMFsv9Z27+IYtYGklbXep0h0sMGdt4RUz7MmicaprAzFt3+FWCH1Qqq7LXhJGMXJVMTYZjScagcs1mKDLEDknD3wFOWd+67NyIref/mbMsNMUkd1CwVO0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16) by BN3PR03MB2402.namprd03.prod.outlook.com
 (2a01:111:e400:7bbf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 09:42:04 +0000
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56]) by BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 09:42:04 +0000
Date:   Thu, 11 Mar 2021 17:41:57 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdio: fix a typo in the comment of SDIO_SD_REV_3_00
Message-ID: <20210311174157.561dada9@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR21CA0019.namprd21.prod.outlook.com (2603:10b6:a03:114::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.3 via Frontend Transport; Thu, 11 Mar 2021 09:42:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fb744cc-36f3-41c1-36e5-08d8e471edac
X-MS-TrafficTypeDiagnostic: BN3PR03MB2402:
X-Microsoft-Antispam-PRVS: <BN3PR03MB2402415F21C2A20786B1D18FED909@BN3PR03MB2402.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87JNmIJzVzKQ3RkdSv2hOy34Z8FoUNpYqm/Cg/+D9D8+cENBsdB9QWzhYAXkimZ8WmebW4Orsj+FyQ8dXfG04mzdIjDnwrHZ5SmjUg3Koc0mHG2WdGBenGJgqphakyYNeKFhXqNA55Pgo2yxkm+shBM8IsGyaLBxC+vhGrpDw0SD6jcUjcRP4h6qag4izOSEXzcLJoRT/+NwTKnBam1sznHxuSy9zRUcore/53Trt5yOQRCVsuUXZiRpIKDymOnF0J5JHuMcQR0CAIGxNBn0ba0a1tPf4rMU9MnUpxYjs6qqVYZvv0tXmVA8lRVqgMu4UaP+gW5jSN+tc2zOjHtz2oFnZgWTRtUgbwt5ASLGIrnXSns9KVcWLqOXirgHNUshv4NsB9oLnXFGi7ZpFnHFf/xb7eN8lYjPX/zndceOJ/IibKiOnKXP01bz09VDT+I6Yc4sDq0AU15OIjkMgnL2GE/z0NW/yPLSZDqmtfe+NgxWoHEmDC0oTKVGcAHd80SWrRLU23XEN2vDWhDIrz/sKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR03MB2307.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(366004)(39850400004)(6506007)(86362001)(478600001)(2906002)(9686003)(66476007)(66556008)(66946007)(6666004)(956004)(55016002)(1076003)(8936002)(316002)(8676002)(26005)(4326008)(6916009)(16526019)(4744005)(186003)(52116002)(83380400001)(7696005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hwG1gxPIEYd88Msn6IxuPo7gZR0H2JSKvgpsz4BbxkAK5w7e2nDpateHRgpy?=
 =?us-ascii?Q?xYAs2vvC3+E/9INCZdAGLRejWjicXwXZN09RYuu169rEIpBlUbWklT+WCZ+1?=
 =?us-ascii?Q?j2SRq+7wkzAp8/mGR6pZsncKA88G8lqikBtj6tcukYtWiUsEMvd72geUmhnn?=
 =?us-ascii?Q?I7uC38qI2evZXMPlftglmGoMD52BHtZTF2FaxNwzZdisGMPTC2/iQ0jzc/Vf?=
 =?us-ascii?Q?bo3GsrVwoFYHy/CIM7HHZrbloN82Oc2SQI+XGsq0UypY0KMU+lhwFlhnxvvJ?=
 =?us-ascii?Q?6ERO7o941eE311VQ5HSb0TcHWG4BeceTDRm8zFQBCa1AbHvkwTK6fG9rgsQI?=
 =?us-ascii?Q?UV6j5Uw0ni8AFZkrikHMxgh3SMgsG9cgP0GI1I8NS5Z5lU9YMTBologhg1Tn?=
 =?us-ascii?Q?4CpnA+8ub4WkQpK7MEL9IeWHFckzaPpRVV34oxqGOQ9ZqpnZG3/FFrQyYR5h?=
 =?us-ascii?Q?ooUfdjY7LnFgHJ8+QS+gVrp5tgSXfjPWxVhHs03o6OOyVGWEsy2DUh8hhQLn?=
 =?us-ascii?Q?1G8EshwcIjrqok0BBNYYTG+PQ0jiyCm2ahlBbVaipqrDiysz5N7yYSHw3rHI?=
 =?us-ascii?Q?CASCSfR5SSWbg2Hqj5M49b0kByfVMIzNJFmH9XK5DVC0Bu7c/POH3zdzaKll?=
 =?us-ascii?Q?myBQMb7xgNeknpCLhaG6/fNWlPj2MfIkUbdg0OYQh0zOnv/WSndhPzcFIey9?=
 =?us-ascii?Q?zQpzcHeczHCGUJXK/XmPyd4uPpiHP1o6szz44I7BMtOeR4njLoXGhCjI7S4X?=
 =?us-ascii?Q?WrbQHyzHPC01lXSdgQ/92ZSRwalXUCQ26beFjnfKhID62B024TAn4HtEUm1s?=
 =?us-ascii?Q?jjKvWbNso1c1PMjKeKKIUoRCOF60tOlMowhX9IKRDTIV3oYPfMouN8xA1EDR?=
 =?us-ascii?Q?CQx+LCrSLCRpqlJgZUe7hW6vCMCCQLgRb3Rfvqzuu43AsTxSTNmuQPBeO4wB?=
 =?us-ascii?Q?0h/jAoIn6boibdbTkSw1nmuUclxOc867HALzvBfSgN7IUNpaSU2ztFK+r6Tw?=
 =?us-ascii?Q?hydoSZjWhUEyQAxJFL4hm3f6MiuBzdDgrOBpzlX/0naZv3ruRYX0Fr339qIp?=
 =?us-ascii?Q?GGV7Q+zrf+IfJXgd4GOmKohYZGUSw+FYtMdDJxv39n2uSJzLvYmyrq1rP4+T?=
 =?us-ascii?Q?z40GY3aNUDv/o14MGX34hsy1jd45uM/fwosbyIN7fdTRBcEUDJuidQVdtGNs?=
 =?us-ascii?Q?RLYBKNyHhbOd/E3XkXMORIAbMP9FGgQXcfkGFFVcxXC+t3rQP6QkyCeSmWAd?=
 =?us-ascii?Q?wu0jvYlTjdHxYi75QpWdL+Uh7vkKN8DukhgY+HoDXlRA5H/rlU5i136d2btM?=
 =?us-ascii?Q?eb1B+EdIW1Mv8uZlYGmvoofn?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb744cc-36f3-41c1-36e5-08d8e471edac
X-MS-Exchange-CrossTenant-AuthSource: BN3PR03MB2307.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 09:42:04.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IG/jwnvsOYrd3rcHUROxv945348UXIzagPK6s5Pzv9Nb/6UIUAFA1v31W6mBNIHohtiY51g6brWZp5WVesnqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2402
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I believe "Spev" is typo, should be "Spec".

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 include/linux/mmc/sdio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
index e28769991e82..2a05d1ac4f0e 100644
--- a/include/linux/mmc/sdio.h
+++ b/include/linux/mmc/sdio.h
@@ -82,7 +82,7 @@
 #define  SDIO_SD_REV_1_01	0	/* SD Physical Spec Version 1.01 */
 #define  SDIO_SD_REV_1_10	1	/* SD Physical Spec Version 1.10 */
 #define  SDIO_SD_REV_2_00	2	/* SD Physical Spec Version 2.00 */
-#define  SDIO_SD_REV_3_00	3	/* SD Physical Spev Version 3.00 */
+#define  SDIO_SD_REV_3_00	3	/* SD Physical Spec Version 3.00 */
 
 #define SDIO_CCCR_IOEx		0x02
 #define SDIO_CCCR_IORx		0x03
-- 
2.30.2

