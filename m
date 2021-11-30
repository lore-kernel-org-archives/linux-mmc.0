Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A7C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Nov 2021 10:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhK3KpQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Nov 2021 05:45:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56094 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235352AbhK3KpB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2021 05:45:01 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAUnHF026595;
        Tue, 30 Nov 2021 10:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zbThLQfbDtJt5rHWSBmAFskfGxb3mBNkgcH+VFTUY8s=;
 b=ES0o+sgrEPIVuWM7cTxecK5gNg73LKL7O2qzwvdZNQodpFjN+hWBiPJLp/YPPmhsFs15
 Vc1XaLj76gWMEOzzMoCMcieA1XjONjBXPpfvH7yEA493NGsXDQitdXk7/VBQrI7W3npa
 Rs3BSKddd59Kuyq9cjMzsR3j9dyUjHeSvGL4ait+rf13+qrzTCuoYOBUof3DFrd440RO
 7N1PeaOo70+1Ou1Hwz09ppE37P0by4e2MiI119PVhncgdBWRId0cv9kYDXqvIcDjGbol
 FAbyUOWs6uysd9G99rvL+d3lkDB7QKxH/3kEvP7VFqo8EJtUjegus6D4uvsJo4pbZwPj Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8c80fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:41:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAVjj2047218;
        Tue, 30 Nov 2021 10:41:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by userp3030.oracle.com with ESMTP id 3ck9sy8y7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq7eYqEDIdLvvJq5bZgGQtzqkwdvrZ1tYGySyCBE+NZLIY+VaS6vMl9n89D84LFfCwiw1F3QcdA027UMZtqPKMYCM/5rHBqS5vqd9Ed60mNLU4Q7+qNpqD6pLA2kXMShlQUU/mF3TFiSnhONNdvKRj5m4oel9Q2vnE9uqeseI0VcdsA9NyUmh/HYbMUVdrKnW0w95/cXs+FoEfZ3Dzzh9XxxEzzug/vPXd55TZ4n7n7Cgrs1+Q/E3t9PN+iBOv57/2wnjTQlQoemzeD0WRePljhQKjcRKZ0+AUVX4XPsogi/B/QhrRIOGJ8kMwHHb402AGdxAybhvE+G8fKSL/P8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbThLQfbDtJt5rHWSBmAFskfGxb3mBNkgcH+VFTUY8s=;
 b=B0rpAf2VhApPtx0E2awBLCQfpNkWCfU2c0kuYzn63vU9eRlYX6OTkPzyscY0INrkOh+cTENazCHGvcI8ZxCfVVcgMgOUvdawiSb/gwlV6vGULBUKoVXVSxeC4kAogM4lpfraFqI7SdoXaJ726JcQ7VuDonKTDCWH344G3cprpnFbdArGHxorFcY55XjlZLSrAWY59BPLOb2098T9mvFJAp39v9MAqrnghPVRGuWYBLKRI3aHW/CUyzetjVzjV3ichIYh9/PGH49mV7Yi6xDCAnQCNQn0JeQ1tddOvxP1l4RaBC82hTy9TbIdV12zFSzIoGKch2DaBTsd4+JYJNaP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbThLQfbDtJt5rHWSBmAFskfGxb3mBNkgcH+VFTUY8s=;
 b=swqbwAhDR9oopJ2Mw9ohLPE29iyJzzvCTWepvWdRXmKUFD3ATqKH3cuYQwGLYwhUnmYSt2VwupYK7nR8GeUBlWrjieFOBMSqvR3F9X/XnmY6jJvjlZvMGU2H/j7aDCBOvt0bKy1u6wRI+fuGPxbf1FB+QdNgY8TjBbLEyUq6yQM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1357.namprd10.prod.outlook.com
 (2603:10b6:300:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:41:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:41:34 +0000
Date:   Tue, 30 Nov 2021 13:41:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     wsa+renesas@sang-engineering.com
Cc:     linux-mmc@vger.kernel.org
Subject: [bug report] mmc: renesas_sdhi: abort tuning when timeout detected
Message-ID: <20211130104121.GC5827@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0180.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0180.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:45::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 10:41:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5110441f-cf7b-40cc-300f-08d9b3edfab1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1357:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1357D64F12643110A58FFEC08E679@MWHPR10MB1357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Nc1IHVfgxAQCRBtR1uXkSR1WQIIA/+m8nxPO46Okn9EE4dbGHvdeTar6RZm2ExjkwnGRYr3hj5vsP4uWzBaEQ+my1vzgg3nHq2kVt3Qyf4u0dqtOPKrwmSrqQNC5JE/6KE3T4hROGkoKzbiK21KDbZdlbMPBwyB1URBO5NsriTwDFagd56z2QDv7MMINwCee4HTPJkvPpUvf3VNxFAEzBgqPYA8xSNQ++yydf/lp1bT+IzjbtiJWrVduP5DkO+sCLq9KCnupk+BhlqBJtXGPU3ZVWOWf041qVn/CczSKR0NrM5wDS78fCoPGq2sUy9+0mDt0W0x33kOZMJMUWxzhwDLk8Q1XY0aJGLHoZXgt/MmHck82QrMpbKFcqYm5BsQqx/qNg69Drm5lLAbN3/CHsM+M9Qz1EW5ajRQiC+apY1WiuY8/jPWyRc1dr2ZuM2zIOr5K00Vfg6fzS1z9DSFMGRrmJ4+V0B6CelYaU/zBkzI3pYD7uXcpe2KaDoffvsmvQqkX5DGul4TTZzHH2ffD0BErKtDslGt/MhaQ2zZzvRgvClCPrau2iN4lvfa1JbXFNpTeoSeE19fvExGW8CRUuIfyC9RUECdBhN3cYm5cm961pwkw+XHiHJBEmiz68/caD9csKhXuEOuwJO8E1XXRffBb11MPyOBacDiPeo3aBA3oYqWt3fAaeKwlDKjKhf7y23N4SG1kwiK/Qwg1UeA4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33716001)(9576002)(316002)(66476007)(8936002)(66946007)(44832011)(38100700002)(6666004)(83380400001)(38350700002)(956004)(9686003)(26005)(6496006)(186003)(5660300002)(86362001)(33656002)(508600001)(1076003)(8676002)(52116002)(4326008)(66556008)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oJtValeU3oMxy8PJ0nnwSbqodvFtlSJyLdAC0LywhGJANc88Yoqo4SsuRmjK?=
 =?us-ascii?Q?5pPEhjT2PEAlh6xRHVD2gLOKCD3tcgB/MW5l1FdFkBCo/QhEqzgjUk/su5jC?=
 =?us-ascii?Q?ePJpX8ibrFMRKV4vTwnuaiZJweuzjjajlNtct7zegail7f+W2MT4oTGhrr3r?=
 =?us-ascii?Q?wzxXy9Rd1vTeLvOcH2fHn1ILd0uwianc/hwp4G7mxkGBBTlogN+sAdJVD0eb?=
 =?us-ascii?Q?hAyGgQ0DsgSvap8TmFMwwW5gQ4l6A5DyZOjTOFBKHq7lxHqNEd7qwIni3XN0?=
 =?us-ascii?Q?pUx4AcHF+e4b0m7hv3lcjSoGNMeQ+ZG0tf3faFY54vuo5lORp9/d26QUvg6u?=
 =?us-ascii?Q?2Q46tbqRaqpYO5oYwypIouHPVvsWu0S1i3d3x8kXSdwIqv5dCf0OWE35ZT2K?=
 =?us-ascii?Q?KVehtxzNAdb/wclHV7HIU9FmC8aKZY4OeatYfcLAteTsWmkecKEny0XBqT0g?=
 =?us-ascii?Q?o4ToH8EABgjHeLDBUuqMmkFT28wDIsGjYX2UD8AECWgXM3/PPIARXKX6FKYM?=
 =?us-ascii?Q?7cPBx+SCNTXle9q1cJFtyYaZ0dDuzi956G81gXME2qxq0tinro84VVAiks1w?=
 =?us-ascii?Q?dq0z60eQTL5oM7/+wcsDMyaRMMf3mBVChbQzrGokOLUwRA1MNmNlszG1qGRs?=
 =?us-ascii?Q?Srx6DVRI/VNtZ5f2qIZHBRFIZeLssZS5/1QOsP6CwNHL0TVKCgwl8U6jQu1b?=
 =?us-ascii?Q?czDxPKtWr6e6jxdXbPXDplO17ZR8Fpj2h5FM/jcxKhrZ9O8c7RkKG3r+zN0w?=
 =?us-ascii?Q?FKO9EHqBNMCD2cBd8lEGUP8WU7U3kiz7bHG2ic/ggshFYmkBMl2gkruFhBXO?=
 =?us-ascii?Q?XwthTTiXB23tYa9wJEOydpCFNtjawngkdLbulLA3d4IaxG/Rm7Iq46S1vtO5?=
 =?us-ascii?Q?ZKk1ngaaqM2261rPNpmC5K0bFHdcTJT37Lu+atgIR/1d2nKHoiE+aN3Djqz8?=
 =?us-ascii?Q?A0VysMJXJkIHCKqVRzYFTxXeTchauaLql+Hfv/vLanw8BcB2hLzTUJX27wOn?=
 =?us-ascii?Q?TccAhA7B8dg3bFmAQz42mGo5WRBoJSVUfPVaZhBQN7QLzP7r+YI2qsmNtuQY?=
 =?us-ascii?Q?xPf1hrlWTtOHFHPVsvChZ8dlOYSVksFWj8qdaO/c2b7SZZeMvRf6MzPTiICp?=
 =?us-ascii?Q?W6mUK411HIoH8GmOK89BhHPOcPDR05jWwduxx3y8wQpicSR02qIhuexx39kP?=
 =?us-ascii?Q?8D7ldUT6UJc2sbq9XjIR6mqOJNAWzMWPvpKLN4I0MLjxhK2Cxmp3Oju8pwSZ?=
 =?us-ascii?Q?A1C502mRxEOXzOVPGoE07QqEm/7oh3Jr9UUU9FYT1uey8spp3HkEAh09IzmD?=
 =?us-ascii?Q?pWMoUo4CgE4sgTt4dyAdRAACCKJe+SRegvbot4wAL6PY7b+TiFsXBr134I/D?=
 =?us-ascii?Q?X5ecNZTYhW7CltA5KjsI8a/E5PLkgM9/hzS961z+chUPyr6ocNr0GAXDpzak?=
 =?us-ascii?Q?csMqcdkLT+6eSHaszYPoMfR7kwAyjcM2Mw0ORKCEP0eApek+vmWrqk4+r7IM?=
 =?us-ascii?Q?jKWNo+PwNqtxh//fBkOENe4wp6NvD804yy4iW/LC5a+21m3aS6HeO84OHstI?=
 =?us-ascii?Q?A1R88Q33QpCkgXZ3CLLkFpcgIeQ7DHc8vcV0UDFIifBGgKH3i/sfYiOFBrNB?=
 =?us-ascii?Q?XFjmN5N0m5vzt5e2qvrtW4B0T+rHsM74w5j2DhXyWuyioG42waEtcQOBUqDf?=
 =?us-ascii?Q?/2KJupO6EMX8izSiHtUbDsd6FdM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5110441f-cf7b-40cc-300f-08d9b3edfab1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:41:34.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQXxrHWPlaXNyGl6ibyh0SE+WQdOAQd8/DMwvIxWcU37WrYi0e/Laz1E/K/XhA432ycFkizK26pN//TFPz5aCmcOOlPc7VowWVC/G7nhW6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1357
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=939 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300060
X-Proofpoint-ORIG-GUID: c71MIVz3ZIowoWzDeruTALirUmlJ4CzZ
X-Proofpoint-GUID: c71MIVz3ZIowoWzDeruTALirUmlJ4CzZ
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Wolfram Sang,

The patch 2c9017d0b5d3: "mmc: renesas_sdhi: abort tuning when timeout
detected" from Jun 2, 2021, leads to the following Smatch static
checker warning:

	drivers/mmc/host/renesas_sdhi_core.c:701 renesas_sdhi_execute_tuning()
	error: uninitialized symbol 'cmd_error'.

drivers/mmc/host/renesas_sdhi_core.c
    669 static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
    670 {
    671         struct tmio_mmc_host *host = mmc_priv(mmc);
    672         struct renesas_sdhi *priv = host_to_priv(host);
    673         int i, ret;
    674 
    675         priv->tap_num = renesas_sdhi_init_tuning(host);
    676         if (!priv->tap_num)
    677                 return 0; /* Tuning is not supported */
    678 
    679         if (priv->tap_num * 2 >= sizeof(priv->taps) * BITS_PER_BYTE) {
    680                 dev_err(&host->pdev->dev,
    681                         "Too many taps, please update 'taps' in tmio_mmc_host!\n");
    682                 return -EINVAL;
    683         }
    684 
    685         bitmap_zero(priv->taps, priv->tap_num * 2);
    686         bitmap_zero(priv->smpcmp, priv->tap_num * 2);
    687 
    688         /* Issue CMD19 twice for each tap */
    689         for (i = 0; i < 2 * priv->tap_num; i++) {
    690                 int cmd_error;
                        ^^^^^^^^^^^^^

    691 
    692                 /* Set sampling clock position */
    693                 sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, i % priv->tap_num);
    694 
    695                 if (mmc_send_tuning(mmc, opcode, &cmd_error) == 0)
                                                         ^^^^^^^^^^
This is not necessarily initialized on some error paths in mmc_send_tuning()

    696                         set_bit(i, priv->taps);
    697 
    698                 if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) == 0)
    699                         set_bit(i, priv->smpcmp);
    700 
--> 701                 if (cmd_error)
                            ^^^^^^^^^
warning.

    702                         mmc_send_abort_tuning(mmc, opcode);
    703         }
    704 
    705         ret = renesas_sdhi_select_tuning(host);
    706         if (ret < 0)
    707                 renesas_sdhi_scc_reset(host, priv);
    708         return ret;
    709 }

regards,
dan carpenter
