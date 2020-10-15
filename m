Return-Path: <SRS0=8+sB=DW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A9C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 02:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D29C22258
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 02:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="akQXrwDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgJOCMX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Oct 2020 22:12:23 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:18497
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727353AbgJOCMX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Oct 2020 22:12:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwtbR5/qzGXbNwoL2tkFajZ4W/KlFHSs1yt9CCyw4joDHrdfTuOq31AFsg95gD2u3wiwFQKsoDHvonwvux6gHZMkELHnQ1PyaTt3dMjq/JZ/iUgyzyTh6chTpt9/CiW4xI5M6ZodBtpriykjaXhHG2JRgn2sdCJfzt/NAvXoon9tm6+lMN1EV2VSOYEJs0hXjHiNg9jQhmOMt4g2olqyRKjaNLhDoucBJLmHThSnClaGvtcBj8/JaMxRnen5jpWBRHMSbrI7mMczX8quriMC3IXd+kjhnaq5TWisYLljjt7WzSqPCPDEGNvA+EWJGJrmMxlqlEdGgpyCotm14Bw0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q06977gIik9VXAvhGfeysEajETR2ZPqhql1N33+8bX8=;
 b=N41YLhhCK6HbHqYOkNaBH6Y7rf9Dj5tE34m5x4Rcnz0tM+QDgBHsawRrPq2IbWajO+AYTkiN3HS/ZFSkaudvNja9T5znDmA/9YqqPP5Q1g+FUJnfHZkqF60Dq1qRRoD2U/hEDivaB2eQJ6wMdrQ3nWxNg/OVBOvKfuXWC4n13PRndk5kghfQV6znNIWna2PpbP/2iYIT5EUI9SCh6YbgYRCWAolCMcB4B1xQse8Wh0T77LFEv6+3/J+8hSlxCdEPVHECkEFx2oWMeQdabv+x1/5r/g7fclSsGF4dwdBRo5z2p+kqKrCkiZRXsLTvzAmKo44JIuvT3G5X/9WhbpBI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q06977gIik9VXAvhGfeysEajETR2ZPqhql1N33+8bX8=;
 b=akQXrwDg4YdnGGkdQ7409BqrX4GmZclkR4Tnt5M3ddj7PflOloOrXM3Eh8bv7O/mifqfVOGRFbI/DzhXYs4OD2QJy30Eq5VRNYa957GA12r+jPhjPY9qhR8Xxmby3F1MvGdoqA/ftyS/+emPKfsdXq5GEldgZUyADVlBkUprsBE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB3321.namprd03.prod.outlook.com (2603:10b6:4:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.44; Thu, 15 Oct
 2020 02:12:21 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 02:12:21 +0000
Date:   Thu, 15 Oct 2020 10:12:07 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, zhang.chunyan@linaro.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode
 is true
Message-ID: <20201015101207.3a88004e@xhacker.debian>
In-Reply-To: <2c958ccd-e21f-c660-2259-e7051d95c205@intel.com>
References: <20201013190851.715df9ad@xhacker.debian>
        <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
        <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
        <20201014183212.475a789d@xhacker.debian>
        <2c958ccd-e21f-c660-2259-e7051d95c205@intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.15]
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.15) by BY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:1d0::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend Transport; Thu, 15 Oct 2020 02:12:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c385291d-70e8-4ec5-4670-08d870afbf81
X-MS-TrafficTypeDiagnostic: DM5PR03MB3321:
X-Microsoft-Antispam-PRVS: <DM5PR03MB33215CECB3EC9A5549AFA395ED020@DM5PR03MB3321.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUpwOkV1wQsA5W6OqrCxkaOF/smqeJFXLq/9VUn9NkefKAMBrJl6YiWyO6gYvmNch9+ovUwEotiO7eZLALNl4Qkp6mCIBL8Meu++RPXb9rBNFUsaeKtU7RhWNhD+7ZXmMWggkovKBZnl92rEyAy8yxdKODXB5yQiQaj/TEu83rtnYramUwGUHJWly/v4Sc8hre+2AvMcV79hf2fMlTFlK2SKh0atvAXwZA9Q/+yNaAW5ATcwRhixUXP9EaTWFhyJ2M4nEY9rgLamE/NmNFtPMWAFRvrh5+7EYk9V7aBx6zP3sTozMSgxoOY5sUTn95iOhK3QmZrSndcb0sYFf9ixiKc8+4KWfNuelT/jKDuPofdmSAZ8wwJMteD3euaSw5MQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(6666004)(8936002)(16526019)(4326008)(54906003)(1076003)(53546011)(55016002)(86362001)(52116002)(34490700002)(66556008)(66946007)(316002)(7696005)(5660300002)(2906002)(66476007)(26005)(478600001)(9686003)(186003)(8676002)(6506007)(956004)(6916009)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: N9CbMJbU8nqpN+T6yQW63Oi8Trx/iBL/ArI/zRRS7BTI8BH0qxxFfV13+h42vbMmQ24i+SzU+U3G51i+TyEfIuu+OmTaC2MibZXG09jyLpjS2gPKtXDkIj+9J5b5J+5apd/IQHrjRomTg9yv+kECwWW1XhC0FHf8Ju8ZhKHdci/gqa2avtwhhgZyaE9M93hwJWTCOR9QQgzTq5XZCa8efCGTpDdtz5UmG4K7kSAtvlPp+10HWUJVNCJb2Aa36uGCz3xP0ea6ey+sfw8t4sWueW+1FaCenb013HmugJ32t26zT3wUNlUZw/DcoBJmlme4PHAWZ032U/ELqdFuduUyeaf1XASYAqErdeSLLiPDvH4vjxBAdHsC6nCeJBC7XVTP1y3kOCmiWCh8rXZvZOkAJerbru/7YoUekwJJDvT2DDGi4x5mNvf1JOieGSWQtTpmuVkS7tIJ1UrJ0xED4yXKqvYQB+QqAdQ1agR8jSPmyrqjy0zlQ676EyZJsATrUDSXw0/c2S4VPpAApnqEFT7F20q91bWPKwKlLIB/QnSmGtf0oc+15s1oRvSbvXM6UfVUKF5ZrftPIdnkLXySwlEsgLbl7+X/84FlxICadxI6vXiK/aQyoh78tcfTpZy06Q9Q4AWN00EKMbrUZ5X4ipun1A==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c385291d-70e8-4ec5-4670-08d870afbf81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 02:12:21.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLEw4SOW2vlaTD50l9lemCXNRBhk/WcHjNi900LldjJKHqP0dEWpdYrPPEWuR9EVpRF58a13XB4qW3i+eKQ81g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3321
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 14 Oct 2020 22:44:50 +0300 Adrian Hunter wrote:

>
> 
> + Chunyan
> 
> On 14/10/20 1:32 pm, Jisheng Zhang wrote:
> > Auto CMD Auto Select can only be used when v4_mode is enabled.  
> 
> The SDHCI spec. doesn't seem to say that.  AFAICS it refers only to v4.1 not
> v4 mode.

4.10 defines the "Auto CMD Auto Select" mode, v4 mode bit in SDHCI_HOST_CONTROL2
selects V3 compatible or V4 compatible mode, I think the v4 here includes
v4.0, v4.1 and v4.2, so if we want to use the mode we have to ensure v4_mode
is enabled.

thanks

> 
> >
> > Fixes: 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto Select support")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 592a55a34b58..5e0ec5df4074 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1386,7 +1386,8 @@ static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
> >        * Select' is recommended rather than use of 'Auto CMD12
> >        * Enable' or 'Auto CMD23 Enable'.
> >        */
> > -     if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
> > +     if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> > +         (use_cmd12 || use_cmd23)) {
> >               *mode |= SDHCI_TRNS_AUTO_SEL;
> >
> >               ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> >  
> 

