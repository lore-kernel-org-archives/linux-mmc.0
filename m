Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A26FC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 06:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA822054F
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 06:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="iL3k30Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgEOGA3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 02:00:29 -0400
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:14173
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbgEOGA3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 May 2020 02:00:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES1qZLGte81VaptSpdV/owe4pY0VzgmpOWrJcHqkSkXzttvr+60dbhmro7DXOUuiO8MNLYwIN5bmKZAvmVzrgg3rRJoSSqFDcHqONDIPznt/Lj1qY3/ZcHRuuliiMM4npzCD2grvJURpYOT5DjldPYv7NgB1Ho3FapkZO0ozR6l2FuPYPob3Ca3wDs4aKc0qrD5xwChdePNHiA05Rr0ljUQEJMmtSNwtjsFIuYhLxGg154uVsEsKKGEPdGYa4xptCV+bC3VOtVOaxYXWVGZ9Cpcf8nzJBfksCz//g5R5QpMgbSUCHrpUwY4XSrN0CZ1CKaZ2r8qaogsaFd04pig5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZmphEWzFoXNSIimU8oVPZ9yl+6ZZsKgKw/fF+FxE2A=;
 b=aaIHz8I6rUCLPsXtchn9MSuDcPYsLkmptzLtsVKbsXst618R7nDo8y/Q11RUntqzpv3/UFswDY7V3c2mJyvqmZ37KGOCFAdc4dmK1jWzXgRprXDuUfHge3yEZoDpux0k2YE+TxHSTl+nGJXj6X+HTHByeOMh/EqErl27Dzzeq6TCZSuz2NTtC2ZZD1cemDULWj2e5Fm0hxFPbF1yAn0SA0Bd1gW8WsfJ8WFh5ByhUOWzYNcTQQPb5Yvxjjjg/t/gcaM1TPe3NZ/l+wrdA5zWM2bpREIBRnAkQRfpJnzytoLPv2xRgDS9NvFC/tMCLfuOFybpMdbJEArq5qc5xFN/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZmphEWzFoXNSIimU8oVPZ9yl+6ZZsKgKw/fF+FxE2A=;
 b=iL3k30LdiQRtJbN0KQ839F8dmsuKCv5M2H6p9qN06YNonW1lcgwYWDnNZsGNfLSZVYgzEMmsatjaTHglHgwVRzDTlDItv60pfeSrGXt0bWCIeatEgQjG5B7XSDBtWy5qrQ/i/1T0xQDojfAqLOQfvaCZoeuoItDiIZ2aOA70y/I=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB4376.namprd03.prod.outlook.com (2603:10b6:a03:c9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Fri, 15 May
 2020 06:00:25 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 06:00:25 +0000
Date:   Fri, 15 May 2020 14:00:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "mmc: sdhci-xenon: add runtime pm support and
 reimplement standby"
Message-ID: <20200515140008.6c8a8f2b@xhacker.debian>
In-Reply-To: <CAPDyKFpUv=HGBAEchH25tdnRdUSAvbCgGGCgN8uuvPCQ92xwZg@mail.gmail.com>
References: <20200513174706.3eeddb2b@xhacker.debian>
        <CAPDyKFpE_uqiNQ22Fq9hDfb5pzMBdgmwgUbasEsEdXFkEOmq6A@mail.gmail.com>
        <20200514134507.54c17936@xhacker.debian>
        <CAPDyKFpUv=HGBAEchH25tdnRdUSAvbCgGGCgN8uuvPCQ92xwZg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:404:28::24) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0036.jpnprd01.prod.outlook.com (2603:1096:404:28::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Fri, 15 May 2020 06:00:23 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58407cf0-73fc-4797-0a6f-08d7f895429c
X-MS-TrafficTypeDiagnostic: BYAPR03MB4376:
X-Microsoft-Antispam-PRVS: <BYAPR03MB437625E3A5B143A0578CA9DEEDBD0@BYAPR03MB4376.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTN5dzrMY1/Qs0GglqOJVStDUjH5vtjqHKeJI7FyS+qL27JhxHDC9TivvKRP6yYOdLmQKwSvQQD0HRSx1l6mqcDS+4yORvOn3kgnCybiDPK34UJ8O72jvJ6kxwRE9EHP53b7FmBgOyVsyM+MnNNM2eipOpuAlhVOLyz2hgimntdtfAB7l7Y/5QEz1GdCqZPNukKjcZ36IMoBWNGXJvszeL+ErMY6vA+W6LZOYxcGHNp1fBCNJDFp8mZXqpQnfx9Un6hjMYYQD9sqQq+6ztLDrdo7uMCwL9VhmQV+kWJ10KGe744P2EfN2/t9quU6EkHu9h8l6ntrboE5gq5ZHeBCEiedO+8THfr86HOG48WotWwN9IA1uJnr+UiVpVT1l3G4V2A+MKMZy1lxnuCXMA7fjrW9XD/XDTFVZbAnc6vMH0yK5C6x+cMFxkD+4a8in/AO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(66476007)(6916009)(8676002)(5660300002)(66556008)(956004)(86362001)(316002)(54906003)(7696005)(52116002)(16526019)(1076003)(478600001)(6666004)(26005)(186003)(55016002)(9686003)(8936002)(2906002)(4326008)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SBxkCJouT7mMWQ5naXxvQq3cj652HKDiuGPe288PSeygMVN8QkJf1YIKSOqiUYVCNET4zDziQ2eqR4TnzeshQa6EJr3pdibFHIHRybM5yfYoyx0ZVGum/B6eYVbbaG7Sj0gOLYL1NeaFI+xRVxD8GBbCNzrJj46czjfsugmPz08C5CBVPr/Orab/TdZIQoWplNl6ex0Mv7/X+FWCjTwniLBkhFwH3A/OVK6Y8/AkdCJgHr/v+RWcTeMerhKVvddn0pnhdrU+8x1oh/sbrL0BzQOii1SijAsodMiPDOJu3N5zKDxs7WRocDqiHci5+Qx+H/I1Nfn6mBN4480v4MDxh3qgKEgXtCSH6BaYBEojT73ccLB5IYMQk/6+pIYb/NE9wCSUHrC0P6h/ss7lRYVtV8RETtHPdr2O1vFp3Jhu63AnX50jGb3cEOll0/3MF/w4Xpes324TprMLBkCs6Ky1E6lbpFg5+YKwXx4t2X/x0ERRpz4IG9dOBeez1Z2Wk/n9
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58407cf0-73fc-4797-0a6f-08d7f895429c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 06:00:24.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADqSttMrzoZ5rBHDoYvVbMvFn2GTL9WbcML3VchD4HqmuhdTt7KblZtyldXVlTsCFIVmrC70Yh5SrgvhQ3XhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4376
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 May 2020 12:18:58 +0200 Ulf Hansson wrote:

> 
> 
> On Thu, 14 May 2020 at 07:45, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> >
> > On Wed, 13 May 2020 14:15:21 +0200 Ulf Hansson wrote:
> >  
> > >
> > >
> > > On Wed, 13 May 2020 at 11:47, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:  
> > > >
> > > > This reverts commit a027b2c5fed78851e69fab395b02d127a7759fc7.
> > > >
> > > > The HW supports auto clock gating, so it's useless to do runtime pm
> > > > in software.  
> > >
> > > Runtime PM isn't soley about clock gating. Moreover it manages the  
> >
> > Per my understanding, current xenon rpm implementation is just clock gating.

what's your option about this? My point is the HW can auto clock
gate, so what's the benefit of current rpm implementation given it only does
clock gating. FWICT, when submitting the xenon rpm patch, I don't think the
author  compared the power consumption. If the comparison is done, it's easy
to find the rpm doesn't bring any power consumption benefit at all.

> >  
> > > "pltfm_host->clk", which means even if the controller supports auto
> > > clock gating, gating/ungating the externally provided clock still
> > > makes sense.  
> >
> >        clock -----------  xenon IP
> >       |___ rpm           |__ HW Auto clock gate
> >
> > Per my understanding, with rpm, both clock and IP is clock gated; while with
> > Auto clock gate, the IP is clock gated. So the only difference is clock itself.
> > Considering the gain(suspect we have power consumption gain, see below), the
> > pay -- 56 LoCs and latency doesn't deserve gain.
> >
> > Even if considering from power consumption POV, sdhci_runtime_suspend_host(),
> > sdhci_runtime_resume_host(), and the retune process could be more than the clock
> > itself.  
> 
> Right.
> 
> The re-tune may be costly, yes. However, whether the re-tune is
> *really* needed actually varies depending on the sdhci variant and the
> SoC. Additionally, re-tune isn't done for all types of (e)MMC/SD/SDIO
> cards.
> 
> I see a few options that you can explore.
> 
> 1. There is no requirement to call sdhci_runtime_suspend|resume_host()
> from sdhci-xenon's ->runtime_suspend|resume() callbacks - if that's
> not explicitly needed. The point is, you can do other things there,
> that suits your variant/SoC better.

Yes, there's no requirement to call sdhci_runtime_suspend|resume_host().
But simply removing the calls would break system suspend. How to handle
this situation?

> 
> 2. Perhaps for embedded eMMCs, with a non-removable slot, the
> re-tuning is costly. If you want to prevent the device from entering
> runtime suspend for that slot, for example, just do an additional
> pm_runtime_get_noresume() during ->probe().
> 
> [...]
> 
> Kind regards
> Uffe

