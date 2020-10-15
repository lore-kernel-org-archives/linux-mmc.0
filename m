Return-Path: <SRS0=8+sB=DW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2703C433E7
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 06:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426D922249
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 06:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Pu2NSttM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgJOGZk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Oct 2020 02:25:40 -0400
Received: from mail-dm6nam08on2046.outbound.protection.outlook.com ([40.107.102.46]:40698
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727906AbgJOGZk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Oct 2020 02:25:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5lRUJ5eD7VzBFvKRzBlUcLAz9lr5o+sVz4O5B5LYVVpzgfYHLLTLzIz8mwvvsPwA4nu7s3skKizuUbt5ZjBV23XEEyjOPE4JQjbzC+TIdBR1sEJxOC8RvE4a2Cxm8kVaolI6ejRvv4q3Q+4O9J8L3ePgyV7FYLpPurAtdNWx5aEZTK7G/oMDyTT0R3XNAt0UI7XeRmNbmM1Mr3PquchqLN0z6mm1moqdiZU+wFWIzMKVU8FSVckuXZ/udbTvd+XAClXwONN3RPNh0Cdpa/TjlVrvt2mF+4zG2djNvHomi5rmS/9QFLdfI5REoHqGBoAPp18Vy0GiCTFj/N1gqOu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U30O00IqCzY+Hizp/KNYCWtSFU/RGETFGF34JjU2cw0=;
 b=ZyVCv3CWu9XkzpOB4uBGHKyPkEl2u96m9bJaRdcL2sbQP1scu35ezwSZ57/9EpzP48oQEMXbv2j8iRD9VUtvGzx4pVP7YDxpNoH1wVeW5vf8BLdn0Ygd6QlY1lJ9lEV24gqbZgTnZJYFUFmnM3DevBk5qNUO7B4/1jnV6r1jCxADyn38vEuKDtIvW88jIlqOQtO2CpOlHFyMzmKrKi6nfjP/ZthaJhZRIZ90tzRoYZjfSJ4ov6L2aGk0fhQTMucbYI4ojKo8owE8L8wQK3NY14d8LPiahP7iCY7CqYrGLLIqRPu3IcFy5ykehk8hQT+zU7ZFwFpqhwYR+4YRGyuMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U30O00IqCzY+Hizp/KNYCWtSFU/RGETFGF34JjU2cw0=;
 b=Pu2NSttM+0IT46bnt6ixhw7+EzAkny1w5R1R8MntmROKMV0VmZs3tpB78Xg2WlGXLJNNQG5xfgRaChbMgRskHNKJ54yK5LCX+EB7hnfLBSIiBXhfN0x7h6gbvvdDks/z0wy1VFMn28exQ3R40uh5WH0YVI6K68iHoHCh5vgIQtM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4444.namprd03.prod.outlook.com (2603:10b6:5:106::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 06:25:38 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 06:25:38 +0000
Date:   Thu, 15 Oct 2020 14:24:06 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode
 is true
Message-ID: <20201015142353.4ef890ed@xhacker.debian>
In-Reply-To: <f1d6c1cf-b74a-701f-5136-e6be7bd4bfa9@intel.com>
References: <20201013190851.715df9ad@xhacker.debian>
        <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
        <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
        <20201014183212.475a789d@xhacker.debian>
        <2c958ccd-e21f-c660-2259-e7051d95c205@intel.com>
        <20201015101207.3a88004e@xhacker.debian>
        <20201015103840.3935a420@xhacker.debian>
        <f1d6c1cf-b74a-701f-5136-e6be7bd4bfa9@intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR0101CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::25) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR0101CA0039.apcprd01.prod.exchangelabs.com (2603:1096:404:8000::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 06:25:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8f9de76-7af9-4a6b-8236-08d870d32187
X-MS-TrafficTypeDiagnostic: DM6PR03MB4444:
X-Microsoft-Antispam-PRVS: <DM6PR03MB44444D39A31F6A9A43C0D2D2ED020@DM6PR03MB4444.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnJyjNtT2C88ftoW9Uetjay8R5AfKIEYarYXCR1AA2IhZEzEb3luwJuPSfuXfYgwUV1sto7JuArrQoFwUWmF0pVegBbKQDBvi1y6vlhyWvKv2ompYtdxCU84ocxibLBScm1/tP/l0gNB22QDdMcwlCXiGSPvWsAi+3o+fGjB2soKP1YZ7PbCfUh419alWJlmq645St2x87Y6OnndeejKfC8r8UJg99T5+bTRsxl20zrlPxRqj5ix/dvK0i3oS5eXCGKFF3DStWriy9wBuDCqliwNwH0lc67u4WynjVldSJQ/Mo+L95VLeh6gDSRlHDo9ZHSGqwymxoPW+f5nLluq77W0qBRsRp8g5A2QhIadF0sGbRA4CCYPzOuRH+0a/9QH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(86362001)(26005)(66556008)(8936002)(66946007)(6506007)(16526019)(8676002)(186003)(956004)(7696005)(53546011)(2906002)(55016002)(1076003)(6916009)(5660300002)(66476007)(478600001)(54906003)(9686003)(52116002)(316002)(4326008)(6666004)(34490700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B7/boR31pWcIc1OcjmTFfiJ3t8fFxY4RJAPfDkj9dW3fsBy9U/KHqaF5np2EFhflCx8h/2hTB73UsxKjPdnESVT7FXGoVTXol4oBN5m7ljPWhGOn8cV20UEVcCh24/rekJFkrjEu1B4KT4WKrPtIt+m8SJ+KYKP4fTksXtNYhy48oRQJf4e8S7MIqH2R+EAjmrjVQO4FX8fRHphtkaE2qqHW4WAbbwyt5EvTsN5QrqufuXlq23Ai7VEZ14XPKG38ojw3ErXEjSp2cYYiS25zDDi3KnvKjqh+Aj+yu0z9s52UJcbVhTEsAbTykdbEYw1u3PL2x7pm3tAvWewgMC+S+/k3cFgk3AVOKzMi35VLAyqQ+GPXhSFxbuNaELUwqpv2ka6T05ss9Zy2kZxjpd2eFmkFcGLCG1Dm8X3dgPvkxv3O3/JRebAxLBF+ml0ksqMRtYOQOiZj178e5lJtjK7ts0vBWKLu8lUD6J6biTdcXjdlXqjGMzjpYsT2tFFLKkQFQWXeRMyzPzWJUBQS/sfkL16kMSEo0aX+OqBzutp5DfFOSXuLkmaLdJPsDJp8ZWi7KpF18i/8QKFrJFVe9eneEU3gBZ6KFy4VwYyZpIxZ7Erd7KuO7hSNcCEcAdfmE9Q87ikEYauldEbyXStPYicvTA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f9de76-7af9-4a6b-8236-08d870d32187
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 06:25:37.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrM9j87PlmBsZY0Hj7z8B2CthCqJNf9mSo+ciR5tka8IPG2Z+XyU+qAKKEfqH8pOTzywbmgeeQMUuqmcZEvdOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4444
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Oct 2020 08:57:05 +0300 Adrian Hunter wrote:

> 
> 
> On 15/10/20 5:38 am, Jisheng Zhang wrote:
> > On Thu, 15 Oct 2020 10:12:07 +0800 Jisheng Zhang wrote:
> >
> >  
> >>
> >> On Wed, 14 Oct 2020 22:44:50 +0300 Adrian Hunter wrote:
> >>  
> >>>
> >>>
> >>> + Chunyan
> >>>
> >>> On 14/10/20 1:32 pm, Jisheng Zhang wrote:  
> >>>> Auto CMD Auto Select can only be used when v4_mode is enabled.  
> >>>
> >>> The SDHCI spec. doesn't seem to say that.  AFAICS it refers only to v4.1 not
> >>> v4 mode.  
> >>
> >> 4.10 defines the "Auto CMD Auto Select" mode, v4 mode bit in SDHCI_HOST_CONTROL2
> >> selects V3 compatible or V4 compatible mode, I think the v4 here includes
> >> v4.0, v4.1 and v4.2, so if we want to use the mode we have to ensure v4_mode  
> >
> > So if we want to use the "Auto CMD Auto Select" mode, we have to ensure v4 mode
> > is enabled.  
> 
> But that is not exactly what the SDHCI spec. says.  It is quite explicit
> about which registers and bit fields are affected by "Host Version 4 Enable =1".
> 

Just my humble opinion, this is implied, my logic look like:

Host Version 4 Enable == 0 => only V3 compatible mode \
                                                       => v4 mode is must for auto cmd auto select
No "Auto CMD Auto Select" definition in v3 spec      /

> So the question is whether this is standard or a quirk of your controller.
> 

other v4 controllers can do the same benchmark test after removing
sdhci_enable_v4_mode() in the controller's probe.


Thanks
