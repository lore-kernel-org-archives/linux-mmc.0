Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35321C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Dec 2021 15:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhLQPEK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Dec 2021 10:04:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53434 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237648AbhLQPEK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Dec 2021 10:04:10 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHExski029942;
        Fri, 17 Dec 2021 15:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=NCJ/q2FvcyrO4v0OVpiwBEa97AncAOOdBqaNRsAFaBk=;
 b=Gp/hc0svKSQeifmGq4hX8wa+mGoAnuOP/M6sKXuACHMJJUs5rGSHjvXQrYtLmukFReMI
 wbfcy7ZJJE5MQ7C4bfr/YQ0YbbtQpzvstWoROpxKP2DGhWtt6uLuPyECh1vu7+6UhtX+
 6TRdUt2WzUJD754RI/2PkNkR+a70iDJuy+gCPafcyVdOExRt61Uh3y6imy/fQC9EhMO6
 QvPJ3XUefUiMh+gPrwyPz49//sC6LjvmRs/yWsFfl+ZIM+DIb9rPKGBR7kVSDTJ0dStd
 h0qAh2KEJmr2LqXJBW2P8mvcxi+BY35G452cyJr8RQCZIWrRIcd9CDG0ikSFCUTrcOL3 vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm5e1rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 15:04:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHEudqL149365;
        Fri, 17 Dec 2021 15:04:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3cxmrf1py9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 15:04:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDAMlhp2B9m34lEzpCd8ZUmgA+JdQSvZQcE/ctlxQSBp/Q9+Q8WmueIvppnkUrm+Fv2hTBRah6NWI27CzAAz2yD5L9+N5ApIu/MA/Crok7xHGUvmr2aPJzB1lYNnDMdgNV7MtIvdpcu/a+0I772TJzo+tZQk9c3Cnh9zZRqojACFRrsI26amcMgbSPSAzGiRwgV4wqXvw920NOBqJU5L/JuAB1w4Ik0CCF9EzgMnxp9kHZoL1wcKwt8geQzZjNKQPZ6fLTrkeezUC0MFfxTOvJwby8UpPALIZ1fXOAGVzEukwwgwQJgPvigokw5e/7OjEzjT0M+u12HKlCf86EoRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCJ/q2FvcyrO4v0OVpiwBEa97AncAOOdBqaNRsAFaBk=;
 b=MUXVnF2KevFfSILwXGgPQuz8s2OPD7VU3EWqwDqDHi4kxx8Gnwo+0ykFdEK3J7OzTWE7jBsCtkmp/kVe5mEnpAHDwJ5sZxJjp3qiO1Bw6qNT8glwiYs0mQbvK9GOFTWZWsDrMtfm30WAZUHhs+Pm5KD5RLfCRhuNefYWdybAsk5UAXt9JhDuk0+Lfq39bBVDwj8jO1LL8itLgtlMCNekrWfxtGlQFfw5yfMVUuUO/AcLDyG8WtxSY+N7YC2WblJ/74x0Km425UPk6OYszu4X6OT0Dy6tEjRmWoL1cifRN+LmMh/m0woC6udivmiMp0B/QgngV7AZ6matTou0HMTs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCJ/q2FvcyrO4v0OVpiwBEa97AncAOOdBqaNRsAFaBk=;
 b=YxjWVC0xX7v5ViMtVg9Q6NuMKrSrnL86hjNTs1f4PwqaEK7mKrewqfg+78U3QCm9RStiHy0AEjn/5UMquuZPbJvlj8gG/PMvOgMPUhpxJP0hjmgt/KCzwdBuAZhfVogoicgghZ82TaQAtJddosUnSHvQq+9Wg/Y+7KRVqRdrVb0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5849.namprd10.prod.outlook.com
 (2603:10b6:303:19b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Fri, 17 Dec
 2021 15:04:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 15:04:01 +0000
Date:   Fri, 17 Dec 2021 18:03:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: clean up a debug message
Message-ID: <20211217150348.GD16611@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0149.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac41914-25bd-4252-fc0d-08d9c16e758c
X-MS-TrafficTypeDiagnostic: MW5PR10MB5849:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB58494E3FA15DC5FFD6AB84168E789@MW5PR10MB5849.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHFz+eXVwrYyTtQcc1kpnvHWXmRtb6madBLYVF6Ate824RZ45R2Y5TccxBumb+GLuVZI0MiN/f1e1yLHUP08NgabszaS9g8tZvGjEDwd8m+1a1tErOh08l4FinLZJEg1jvNv/cX93sD3ka3L/YJcPpfY9HTtwoXOTvpr0IybcGqyyjAN8ryvNX5SDLH24gLIg4LPgOr7UWwbVHkX5ZU5Y9HKOiR+ekCw96+QBQnpfe35pHfZBOQWchpf8a8WMQlOlDWHEsVfPptb1njobXj36lGV9JP2QkQMGJ/GyO+zfxhpNeylfVFfFbaczeFTGTC7vINPPopp0sy/L+acBc+JfEynIJankd11W3i3JcVaSsvoCHllJz5TpuLcTzMNQ5OIonrS1cvarInp384p558FNU6FzDZ+n5zV9CAAXbG/CV1xIeb2nuf6xVuSTN94avZLNh2bnxWuJPyPhnaxbQoFhM3sAnXXq8dSeAEyNiJckvjxR7dqXDHOA9OoOK+BTB//kw3sPh+tYNdPnHOcOOdxIVXidbHJVuRTYFBb6h264nEOugmbOC+ytYPue4NrbJI/ESKPDLSa7gKmYuh8HcQppA5GtpUjeD8eapaoeGdANpaa0D+MaLgdas68fMb6sLUOhJ6DPXpsHoZCFveVOqk5Ha9TpGV3QO0mqSteqlczFKSJDuhbXP7vr5nF1zYH6eY4MiMq6no/KwISMitDyCIEUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33716001)(508600001)(110136005)(38100700002)(4326008)(66946007)(8936002)(44832011)(66556008)(4744005)(6512007)(52116002)(2906002)(38350700002)(6666004)(1076003)(66476007)(9686003)(6486002)(5660300002)(26005)(8676002)(186003)(316002)(86362001)(6506007)(33656002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NOaUwIFpkeYnYwSHyb4QZLJcqw9D20f2R9X6MUbbTc23t5REbKlpsld3Ry5R?=
 =?us-ascii?Q?W9RbC/4ZP1YRS+MD2ibR9526JGIKA0MOy5aXbzVSBWnLUzhg9/V/aktUvzQB?=
 =?us-ascii?Q?hl4w62VL6n9wcEFJd9Imacl0n8ThoYwIl1zBtz64FEsl5L6sNVXbqjpcmgJn?=
 =?us-ascii?Q?EdJPX9BmATt8h1AP5KLCb47C4lWxEhrVP4DRcN8mI2ddi5wIglzZeqN/RehB?=
 =?us-ascii?Q?DyhEqlHewE1mQEadm2N2KfCifNbJelYIOQgJYjoAqROUHz28cNO+lUNlEUDZ?=
 =?us-ascii?Q?rJN8u8ETAi1frU7BQ/a48MuAb2HPCzpyGHclJEpT/QXmlJGJc3gSmUxwS9nA?=
 =?us-ascii?Q?aFPRtUb8kpTCDdBPY4QaN95hVDaz5JY/0NUQdvJrU1HuMrZAuDuh0GuV8tgg?=
 =?us-ascii?Q?THPGiQh3nHWpCahfC09wR5193qJuEKVwrbaPGIOrCRV7l+OAI+w2MyH/zozb?=
 =?us-ascii?Q?43yufiFp2gB2P5ypF1FskXqWEPn9X8vg/hdb1WtCWm3Ue3v6wcxSFWV1HeCL?=
 =?us-ascii?Q?edi8Zv29BJAGjSgQMRQ/ts7eG1JVwOhjMomwO2hdLJ4nPNQSe5uCExehz3rB?=
 =?us-ascii?Q?i1gZttMKHOSn/kITlY/5MKzM5F7Pt3p/W7KaYKW1mD5qbFdS6Cz3O6t+mENZ?=
 =?us-ascii?Q?Yk09qfgxG5+zkl0QWyjJEY1PdhV/Zfk5zB/ROJFzJaXrjrviTMBQgAd7f45r?=
 =?us-ascii?Q?El2EEigBUIyNl74X69RLq1wgOdGbzKo/+zDK5AX5PSOnzcSGnq2mjQ68FuGC?=
 =?us-ascii?Q?oRVncd85TQPFeYeLPnAXN4EvI+M1hA7MDG4s/bkf3MwxI2QWQ0nw6A0KonjA?=
 =?us-ascii?Q?d2a4/Oy/aNRvybzmQUht3FTufiVJEVklHC71/IxKbJ1ozIio3hYgYCJ25yVm?=
 =?us-ascii?Q?6t+S8gfEIXAKAczd1l9REBmV/ZT3vQBWqTqQMI+enfAweZKrj20ru//Mdr26?=
 =?us-ascii?Q?4YSqJG6CvwDpKMaG7R2wMCjljNBCy2Bnr6cZ6Ydr3Vhfqnxud0aLPS7Co8yY?=
 =?us-ascii?Q?3eX1hjxnpxlC+O1lJ72/JFx0S0ra9ZPwafp/6W/8AKw+Q5ft5ZBzozw5XQXp?=
 =?us-ascii?Q?Yc8xK4r18iP+4r6X86lGcsbOeecdzSaozbh1Guiz11bFjktS5CJ7wkOzahBY?=
 =?us-ascii?Q?2MuhwzJ2UyfbfEWUjbMLPxH0tvYVDHQZ1kH194d+3JElosPNtLbvd0OgR5DB?=
 =?us-ascii?Q?BrhQjWBDC/mgZhEC8bVgz9A67OH0tuRcgc/FhPQpcThuoix57rywqpkNs9YX?=
 =?us-ascii?Q?6c/8JKJ06vyuylOQrqHrMPowYopBpon/MKHbVmjZKm8ze6+xFKxezYoy3BdQ?=
 =?us-ascii?Q?UCnxt26HO3sR/a+TI62wXJNAfOL5gRj5yA6UHMdrNEJ3esMUGczUQzxlV45m?=
 =?us-ascii?Q?pG4axnfHn+q4dpf36OONjPbe2N05K1xTApSmCL9GbfnsI/w+ZN4Cndqq/4zq?=
 =?us-ascii?Q?vQnJVHr5mbSIyWG9rbvXmuQ1tb1S+u9znmjRea2AtfwLQZEu8hqS0VZnPPAR?=
 =?us-ascii?Q?cIGF79wbZGhGFR6XT6XhaVhIVP80L/HE7zyJ+nB+xHutzXYgBQL/tpj+MF+F?=
 =?us-ascii?Q?W5SZtRXgLVvCsvS+JwDj6eRPEkrDn98qvedcYUeKwiEzLuMR6ZUxJilwpNIe?=
 =?us-ascii?Q?RzaWHao6U/BwnakWStiF2ThCjPZaOSm48Z//fTMR8wrsBC8wjZBqGlm/TwV0?=
 =?us-ascii?Q?TK1Qbvt5360aECkkqtbex3lsfjo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac41914-25bd-4252-fc0d-08d9c16e758c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:04:01.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xgeSHD/Bat+D2GY2Mu6S0303/a1aMyRwHFZubVE3W3bA23l7univRvyzrZ2mrC1aUWFW0rWpHVduiQBwazJENiIdFHRkycPg2feJ3W6Vxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5849
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170087
X-Proofpoint-GUID: 3Yc2W5htr5ZTk8D4anSLb4ZPJSvzR5xf
X-Proofpoint-ORIG-GUID: 3Yc2W5htr5ZTk8D4anSLb4ZPJSvzR5xf
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The "0x" prefix is redundant when # flag is used.  It prints "0x0x".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f2a14a434bef..bec4796283fe 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1307,7 +1307,7 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
 		tmout |= (tmp & 0xFFFFFF) << 8;
 
 	mci_writel(host, TMOUT, tmout);
-	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
+	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: %#08x",
 		timeout_ns, tmout >> 8);
 }
 
-- 
2.20.1

