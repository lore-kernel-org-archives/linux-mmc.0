Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EA3C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Oct 2021 12:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F39E260F57
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Oct 2021 12:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhJKMlg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:41:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54756 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234924AbhJKMle (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2021 08:41:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BCTLfc013478;
        Mon, 11 Oct 2021 12:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=8sECNLMwFJj461sTTmKQ3ipB9XTsCS1BgcShYYB023k=;
 b=B9KCmokR5AuUVCo/xZ4Qu3PtlWMk7K+Iw2qS1pIBZGuxhcGjNUD8sVMhAfP4ceCjPqMR
 b+Qm2Wz1HXCi9pLmYDwjYbcBWWo1vE/gP4P9xJz9UthhG8Q8OA7jSqaopuOOsdRRaQho
 Z9Zsq+sWRQQpphdHnUSuCe3Nuykr1hG5mq8D+/7jTAwIXhq+COezGE/nOeMylbFu4pgz
 +zmQBOEL8N+/H4lOX2989e6hOikx9hHuE1PvR4dYoprtuHezQQ24aSJFEt1bsWFURr4c
 NSJV4z1CMeRfeyVuz8Hr5D+xOt1fAvbfEedzi8nNjJwjJOwMN40NLh6/SNONSqv/eBFJ UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkvh9v2rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:39:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BCVK0b006679;
        Mon, 11 Oct 2021 12:39:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3bkyv865h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:39:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0CUvLJyJjzq1c2DsUVPrB/U0vxVi/Ekt+KNmkTq9KXV9dBjBB40NRxB456ZUOj1WaOXFBTekKukVLi1/6/rkq5F3ZuHenZ3JHx1Jri4bulqX21Ne88xmJXx91z8N3IjexZUDqi3CGhVVPCOJZeUiNff+8DognXc5wR5aYkbmJu185UKzOIPyy7fqzgP7uqsGwphT+gFsqeE9q5Qf4JLeFkjzysWBEzvxTAyCtwrVpE0pM/0Ccain7Vxi3tQprBJMbiWFJ5WfOQYFJLRUld8EHE++yZ9yAj6TrBERgYRggfTLMr40lZiAJDT0GsuL/C5BWCz5cJS+vT1zt31g8+cpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sECNLMwFJj461sTTmKQ3ipB9XTsCS1BgcShYYB023k=;
 b=Xw6ilRiL6vIIkg2YNzVsq0c3v7djYgd65fnQ+F8RsqMLByBkywyFa5QYMCNrf5XxXB1gc5Xhzma3bPsmN3wG4ZOrcsYgxpI7rFphxJBBRDTz/TTrq9IiwgwboCrrLGUFCxSUBcGjGhFJS3K/VJjpHPmc2mpVEW9wWoE8khtj6+R/p9i7rMYToPVE5fG9YaFbzTePd5BDM+jni0Qy7oCodkSEB++oJas+nu3oG+kKnr8vcVexUUyU8VMMtOgM/IsrFcPybC2+XnGOfak9GaOhziOAFnTG8n54Xuye10j37PxfeXmfhn3xS8PihzhxmkF9WawEHyGcbA3+51in7OKzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sECNLMwFJj461sTTmKQ3ipB9XTsCS1BgcShYYB023k=;
 b=zkqc5NMe77VtfvnE0Mqp/TMos0sLNS60EBRa6i3eHlsHGtzUdGFlTveWKCnjBmROF75mqAnehczgDtT5j8qJ3MTIbhbUI0NI7OiZMqI3HrKuE4gfj1OIPiBCeJ7Bdd9J0q4/k4djQn3NODYtzdj9tiliOtVj5tNoZFx+60Wrsas=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1822.namprd10.prod.outlook.com
 (2603:10b6:300:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 12:39:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 12:39:24 +0000
Date:   Mon, 11 Oct 2021 15:39:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alex Dubov <oakad@yahoo.com>
Cc:     Len Baker <len.baker@gmx.com>, Tom Rix <trix@redhat.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] memstick: jmb38x_ms: use appropriate free function in
 jmb38x_ms_alloc_host()
Message-ID: <20211011123912.GD15188@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0065.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0065.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 12:39:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d73f8f34-a3cd-479b-0fea-08d98cb427d7
X-MS-TrafficTypeDiagnostic: MWHPR10MB1822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB18229AE58F87FB13CC8F88A28EB59@MWHPR10MB1822.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5Z4aNK7uIrP0vEcp8/Y7LMfzDkY8nbdUAs5T6PaOejFu8yI4vyIBlyi9yzkuN8HGGPpWYFLaAZsowrN48ifHjc2V2pWUnAerIXuSAjXNiFw38Aj6vlkv1dOKML+i/oE7sShu9lzX1CqBoAc4LnOP7/LLPRWNpDNHxr4pCQaOFdKStyguLiVdqIDc8jHN5rlhN2jUSRK1iu7r2SR8RDNgnyUMtSACbPP10nuupOBadYjiD8LpMqTzV8c5ccp5prC6oN+Hr3EribAZwx0czpy8MYDqCX+uf5Z7BNNRxo1HehwexcRRgGuUQ+RkUzEY/POCnieSdblVm3DkgXAXFXYM8dZxThGM+Ovj7QCe3pi/Fy2QLzeKZo4CpEEvehp47F60miuiV6p56FvKl0R/PtS9cG7Vgw62icBKEeUWVW6kT4kFroA4XD61nsM1qqIs5/ci85/viv1INp9u6+ZVDYCcImYIbViHrDN8iqTszkEvUSJokx9Xu1Dg2I1e2L5/7DL15ER9G6dw6fhMvOpkg8X1EGGULVUjTi8z2SU0w7NTCUHW5U+2KAa6PIPhO8GzRp4NajkR+3F9EAYmZJcQtOwiZV0idNLZpWfF+DzgWRwV/VupRBfi5UNkJtDw1kOCbsNBfCd+ykzU8ZC+6ONxmHBmtsjG1SrwYV7oZFaBjD9/zRxpDOtC16L3Ng/gVFAem7ar0tBudPoyqM9S6YOTYNqdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(9576002)(54906003)(110136005)(186003)(9686003)(55016002)(44832011)(83380400001)(4326008)(26005)(33716001)(5660300002)(33656002)(38350700002)(316002)(508600001)(66476007)(2906002)(66556008)(66946007)(1076003)(38100700002)(52116002)(4744005)(956004)(86362001)(8676002)(6496006)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KY3JSPVl/nnBW9T4tGnHV8jlJTqDeazC58Lay8ZRA9ZglDSGxdvzPlM4PQPa?=
 =?us-ascii?Q?pmubMCWVHxveggAhWeL8lZriy6b7+lBv5U4WmCN3fYS5D+byWtKQN4VdfS4N?=
 =?us-ascii?Q?7l9oPWopu87743P/Pug0wKSsTu7/Wh8MGCULjjp6odjc4d1LzQuyScCWQlXJ?=
 =?us-ascii?Q?NpXhk9JHFL4xmRF9G9GLqnWOfpdSIxTge+iPkGUfTMrzaRdfImY8cUnBiwZ1?=
 =?us-ascii?Q?lUiGg6q3GMEYFxUSFVTIcY6w041gIBrtq6m6KVGRM+C/9ZSrxSw3NhwO/9bO?=
 =?us-ascii?Q?avTVvtfPcGtLN1tL4nN8O2kqA3RLF7m1/7xejn7saJFNwCO6c8zdKhjVvPtg?=
 =?us-ascii?Q?dJ9JcWnLD3fy82Rf/JHdtnwRj/tYeQrWHQ1MABv4WV9vifcmCmHV1I3Wmq61?=
 =?us-ascii?Q?GibxcX+JHnSCLiAVjQ4xKFAKde1Bm0CaLgXqmCowJqUbCdb+t7YinAC9x/fd?=
 =?us-ascii?Q?g5O97KjX8Crn7zZgnEqx2t8+S+TT0/fOO6woYW0RHvz1vbEf+qPuNtgkAdU5?=
 =?us-ascii?Q?z1vPvYd2HjFkEawNFXCWwPtAPwvGTxAgDND2w6TY54MWzvfg+L6KSQ/ZIWGe?=
 =?us-ascii?Q?zRi9s02WNsFTxadZcfh3DbpB+hFGRHuv/Yi7bvuctxkBLW+8UTlZDzJqlfW8?=
 =?us-ascii?Q?GihijZOijckUETMRI2sk6ycAKElweo21ib6iTHq6I/HWvp6wvzLwrgJzyMAF?=
 =?us-ascii?Q?y3BKRTZ3rWopfjc2TbhTdmmTvL0Iq4PIbkRy00VF+nhIw57fnu/LfVcG7ti2?=
 =?us-ascii?Q?3xTPu5RSPpiwNypMpGJzVgcp9BR5kTR19zRDE/GASl8J9A3DwndDyj84n+Mw?=
 =?us-ascii?Q?0dXB/iDDursqS+wf/Fd6yMnI1sVucU68CLrGqHxiMYX4Gbp3nvtjwcblwMyc?=
 =?us-ascii?Q?LFmVLHgUjpvB+dOB7k6MBGPTSl4HYKwzLchJASWK8J2iPhP1Em2JcR80/9Gc?=
 =?us-ascii?Q?JZWwJ/cpFYN2y58Z2bRZQ8Kxphv7MkSriRUX9VLNHZBxgcUGDEle3jsjULQn?=
 =?us-ascii?Q?kVAg38SiH/KpH2AgAems2YBX+RR6dW0T/pt6KX9oojnyaPO6AFJhGoR7Xzz7?=
 =?us-ascii?Q?hVrLWTTTU1earpLvo9QHvCfrDg1gil85WxOSx5VtxfqMaDa7GMU+2SLwuaAE?=
 =?us-ascii?Q?k5E8b+EaKFOp7eR8nwYB0WCwGcnfFKG8jH2NrJsnsEpkC4wSF9k96yzdyFBj?=
 =?us-ascii?Q?B2ryOjqyIlwQepF/A+Nsr9thRcl6SfLC+mNTgbSEBRKCQ6tionH/kHzJTCum?=
 =?us-ascii?Q?VpvhB+Wi5kX5Mw3/V1FRF65dGXvdCi0rzx87XhDp/97W3SafJDTBG9yO+Yni?=
 =?us-ascii?Q?ZJAA3xefhTYI3fIj0qu77lx5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73f8f34-a3cd-479b-0fea-08d98cb427d7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:39:24.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RZA/i8WeHkANdeEm0VhCfuFn/MaTw8cJuCjzkvnjlbMouv4fGxx6WgwHzcPKjb5OgyphZhkyOPlmFMCMSkD9q+PNNrNbodzDLtw5vu8kQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1822
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110072
X-Proofpoint-ORIG-GUID: 1xbUpVOKED4Mx7skKpjWwPBWysVzMcIK
X-Proofpoint-GUID: 1xbUpVOKED4Mx7skKpjWwPBWysVzMcIK
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The "msh" pointer is device managed, meaning that memstick_alloc_host()
calls device_initialize() on it.  That means that it can't be free
using kfree() but must instead be freed with memstick_free_host().
Otherwise it leads to a tiny memory leak of device resources.

Fixes: 60fdd931d577 ("memstick: add support for JMicron jmb38x MemoryStick host controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/memstick/host/jmb38x_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index a7a0f0caea15..21cb2a786058 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -882,7 +882,7 @@ static struct memstick_host *jmb38x_ms_alloc_host(struct jmb38x_ms *jm, int cnt)
 
 	iounmap(host->addr);
 err_out_free:
-	kfree(msh);
+	memstick_free_host(msh);
 	return NULL;
 }
 
-- 
2.20.1

