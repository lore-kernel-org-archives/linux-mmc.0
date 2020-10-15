Return-Path: <SRS0=8+sB=DW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B166C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 02:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2E522259
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 02:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="MleG+c7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgJOCjM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Oct 2020 22:39:12 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:3296
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgJOCjL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Oct 2020 22:39:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS1cCHkwdvpxOgUQdcLcXkn16zhpeCpNATsQ3MT/pmd0Ksz1mpSfY2UkDGMeM9E6rAItwtQFqRRg6vDkDB4w70XZD+06AmEvSIfT/3vqTAiZRszDRSxRBl+cy1TglMtwaAFfd6MGcOMzDBKwbiGZiWFfRm++ok8yasqtXPdCSW3Cu+X4FRtvaAaHWxqbW99inRTEJ06+vS4XfKuOsmxPdjHfFEu2y0yoGehQLWnbWA490AREZUi+JyTdFX/E3aXevfjiMr3LRTYsjwwdlgDrVBfh1vpEYBTeA1uSltpRAP8ph7PtjuysBGhl1AMYzn+MkO+VUhPrUMA0cxllb3e3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfU2p5Eu4fuHDBnv+CF0pmoxB5HzoqiY60+gIUBa8OM=;
 b=TcXEbuGIZ9ZnXd4n4pzu+uposdK1hdcOZE69a2pm1+ExK53g2RDfpnXQOK5Z32iBkaM2Y/zIRx2UTeEodI5V0qBhVT9pJNyVYUZOkZIolKHtp8Zw7aEQwrvMqUCl6R71QQXuz04zMQX/wLYZz4FiKwc6J1P3Lqmb2Iuf6wVMLcVYBhLaRxYEcQh5U5C/KqrUu3e6SXb/+MdNF1r3ibfo8waKxYPW7biOS+WIa3tYT9pXpAc/lBUpnKzVURWRY9oX0ZPrZWUIby7QdwTP/epKs71XlY/3d3uDTk7f4qnR65jLs+Rouo8L1uL5AHP/kf50eVHlGeVkwfOqX8bjmvUcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfU2p5Eu4fuHDBnv+CF0pmoxB5HzoqiY60+gIUBa8OM=;
 b=MleG+c7Fzux5IHcQUdr5qCa3zXIzYu9ue07wwTirJa6buLvQrm3hWyRc2Po3d6Q9K7wWpozejOcvg7NkQ8HJKtnNQHAmBuQ/ueQZlissT31ROaYfDzLRC/AkwfIuzkLfqPwXK7a815zfTpdAEiqg+QeZWOs+l5VIObIww2K8oj8=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5274.namprd03.prod.outlook.com (2603:10b6:5:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 02:39:08 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 02:39:08 +0000
Date:   Thu, 15 Oct 2020 10:38:40 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, zhang.chunyan@linaro.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode
 is true
Message-ID: <20201015103840.3935a420@xhacker.debian>
In-Reply-To: <20201015101207.3a88004e@xhacker.debian>
References: <20201013190851.715df9ad@xhacker.debian>
        <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
        <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
        <20201014183212.475a789d@xhacker.debian>
        <2c958ccd-e21f-c660-2259-e7051d95c205@intel.com>
        <20201015101207.3a88004e@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.15]
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.15) by BYAPR04CA0035.namprd04.prod.outlook.com (2603:10b6:a03:40::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Thu, 15 Oct 2020 02:39:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd6a7fb9-4fa6-4747-36a0-08d870b37db9
X-MS-TrafficTypeDiagnostic: DM6PR03MB5274:
X-Microsoft-Antispam-PRVS: <DM6PR03MB5274029563D60D1B408692A3ED020@DM6PR03MB5274.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPpF9FjuzX4eRwelN8rWWZHK4mlzNQ8i2Keb26nCJNn1Dmw+tO0K4naNWfAR8ZzrWmcxq30nGZmUVnSYw7zkajvePAZG9YUc3o3mRoDOIyttSWHSem0Y92fBpc4UpWfmq/DVxwq8MjwyUnP061TDUYqscUKmwflsU2FXQz/VzFjEQ4yFYVetzxInELNnAFoWT5Cb5idmfydZquF5NBUkKuX35H7AkaAsJaCNfhBSZBqNGSrdZ5rNLCb18YZoqZ7IPnR4IhpQEyxqelraQrEUKjJNhzY5oaKKAlSM5uEIxv2CCtKhnqbiHOtWsEb3RAUsNoUXdL4LyYnzCP7w4v3xZ84GIXcglthitmhjQLjfy+Xo+0XHIcmr2jYbZ1Hj8CG3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(86362001)(9686003)(8936002)(316002)(54906003)(6666004)(83380400001)(34490700002)(478600001)(4326008)(53546011)(6506007)(26005)(52116002)(8676002)(66946007)(66476007)(66556008)(2906002)(1076003)(5660300002)(55016002)(956004)(6916009)(186003)(16526019)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PDERPlzTRIfXaN/WOtY0Ygl/a7/a2yv3yMU4/aZaiuqgwXeiWZCvfPwJCoQPxQ4UQArOD1AUd9uHTIqVr7aQJBIsFgASInAXKW6Ugb4cQV5zCkduQj8JP29c45m57qsEHGIaw6lzlshJtBTqtJZMTuz0eae6V99gGLoo9hJLINmhJk8pE34+U6aBeLUf2WhmusSVwnZdLod9wxaAGBMkHyV4M/GcPe5Q+vZSTqtwfdTHFcPEZwwWMy8MXMWd7OEVhc1gdsDXKU653j+I1KnxfPttLi9LVOw/M9SqKJAqdJs2wDyMyOIR019QlhXG3lxDMTVTEbo0qEhaJXIHSo9AFVaoS28jxXfrP48yQqenbyv47G5paU51KWuadonhwVhou0+skVAHlz2kLUVLeK/tZuM8ZwnIQ0ZfMNoQlzgodH0U6fDNeIlHkt6zLP60JDSVUbHNW+LoxT8OfN92kt44D+R13S/RU0fR0KeHPYPRM1QqXdE5NNCALk/YXcZc77+re5eAj2WKk50SuK/MvVlOadPzSKCejHi4BIJOE2lOwLGdi0dMc+Fnhm8dumipUUSWaxPfNdrwjI4J64HIujmg0WU27M4tPxlf3YU0gXMXoH2zH2tdBQUVztgwx5ZGiwYmNvGDQBZ4lulTT9wfUf/ghw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6a7fb9-4fa6-4747-36a0-08d870b37db9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 02:39:08.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgR6e1j6JsKNfzefFqF3tnwnL7AHXxwDBxgoIZ5jojleo2Z1MBJnkbFCqlryQbEj+rCALMoiNfyypUHLsW4LpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5274
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Oct 2020 10:12:07 +0800 Jisheng Zhang wrote:


> 
> On Wed, 14 Oct 2020 22:44:50 +0300 Adrian Hunter wrote:
> 
> >
> >
> > + Chunyan
> >
> > On 14/10/20 1:32 pm, Jisheng Zhang wrote:  
> > > Auto CMD Auto Select can only be used when v4_mode is enabled.  
> >
> > The SDHCI spec. doesn't seem to say that.  AFAICS it refers only to v4.1 not
> > v4 mode.  
> 
> 4.10 defines the "Auto CMD Auto Select" mode, v4 mode bit in SDHCI_HOST_CONTROL2
> selects V3 compatible or V4 compatible mode, I think the v4 here includes
> v4.0, v4.1 and v4.2, so if we want to use the mode we have to ensure v4_mode

So if we want to use the "Auto CMD Auto Select" mode, we have to ensure v4 mode
is enabled.

> is enabled.
> 
> thanks
> 
> >  
> > >
> > > Fixes: 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto Select support")
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > ---
> > >  drivers/mmc/host/sdhci.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index 592a55a34b58..5e0ec5df4074 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -1386,7 +1386,8 @@ static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
> > >        * Select' is recommended rather than use of 'Auto CMD12
> > >        * Enable' or 'Auto CMD23 Enable'.
> > >        */
> > > -     if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
> > > +     if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> > > +         (use_cmd12 || use_cmd23)) {
> > >               *mode |= SDHCI_TRNS_AUTO_SEL;
> > >
> > >               ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > >  
> >  
> 

