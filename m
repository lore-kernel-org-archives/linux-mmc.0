Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E53C433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 09:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983AC61221
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 09:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbhDLJh6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:37:58 -0400
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com ([40.107.244.40]:11706
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240813AbhDLJfx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Apr 2021 05:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/PqH6EjxUZkFpvRwl6pqEfqtwj+AKMh/sK5SldTPA3UFvvapdsJltj1HB/XnZv9gY9lPlugt48wJx7hSHxOQe6aPbcOd0FB2q9b2LRNSFqIDPX6X3nzQG1V9VH3DKm5Ll4XV1xQiJJLCC5rS6Fj5XKDXcI6zJGx+G/31B9tsa5qf014SnZUD8cN0DtG0cFipDvzKb57dPV2OEr08NUwK9dRfwDaxGewOLDrelhSh3cywr47KUxlySyxn88Ac/jVB9OmtGJQiHm35sPmisyIO0AY1NmWil4vfZora5swth99IXSdMvlZkbtZK12FjCzJ/8k7azih1m9C71tYkLOk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JhqmPVRZO8P8wJqlYcn1k1EvgDpCMrwHqaBBq5KfI4=;
 b=PqsBtZLD8Uw8sSihdkiKjUqqdNB3Q06nnQqtHNyyCVmG5yTxhF3fW8Bq0S6A04Vi4x+MWVbuMKSjU0G+uzE29ehWJo0OBdyC0cLzJVDN8rMhKPqzRl5sfIRIPjSKhlBwubUe3sx3wVqRO9/IRKgJpjj54nJuG3SLd79w9vAc72sORQTkNLboXvcSRpbKtFrM9M5LFPVkArNyofZT9pSJj4mr5n4NgP8rwT3IsqpuHLSNr2JB6lKZQLIUmty2JMTE4nNZBAFayHGFHT9kEh7sbqE+tmCWX1toQwicFAzk/qIl4bYgtEYHlLeRgq7124HPu/VRFLtFcwH20BtVTHcM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JhqmPVRZO8P8wJqlYcn1k1EvgDpCMrwHqaBBq5KfI4=;
 b=gOh8i+szFN6+vXg8pdjlozJa9m8VDgj9N4Hsqu0gDYuZVD0YJH/u2YHyCm9tNZbgfKAQT3re7ssdPrYHdXzYghr2zcxkYuuT5fRqHRitHuV+2z3TRmQBX9w5cEuyHRB4wc7wFAwvBMTPPIYhsh0guVaf1FW16k5GBw63ySkLDnIfgGh3Y1fG4FwGJ/KIOZTNdOnVg9CbMFSGMxTP7U9bMfq1nY8b4YRKtAk/O1sxKtVPjotCT7wYVbqCRPtvYg1cKEqC8XZYqTBOG0aozp25wsgZWA2pfUl8LWCFe9EIJzMco0BHjSfhjnSve5MWuftLiJOKTaSTvHIPm3beSPz/oQ==
Received: from BN8PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:d4::22)
 by MWHPR12MB1950.namprd12.prod.outlook.com (2603:10b6:300:110::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 09:35:32 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::d9) by BN8PR04CA0048.outlook.office365.com
 (2603:10b6:408:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Mon, 12 Apr 2021 09:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 09:35:30 +0000
Received: from [10.26.49.14] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 09:35:28 +0000
Subject: Re: [PATCH] mmc: sdhci-tegra: Add required callbacks to set/clear
 CQE_EN bit
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Kamal Mostafa <kamal@canonical.com>
References: <20210407094617.770495-1-jonathanh@nvidia.com>
 <CAPDyKFo+HwkBaCkALaSuUiTFE_soptsECmGRQX873_WKAmN_Lw@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <69fd5e22-2d85-46bd-8abf-0baf0d97fc95@nvidia.com>
Date:   Mon, 12 Apr 2021 10:35:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo+HwkBaCkALaSuUiTFE_soptsECmGRQX873_WKAmN_Lw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e4e1e3e-c9a4-4e20-6374-08d8fd965090
X-MS-TrafficTypeDiagnostic: MWHPR12MB1950:
X-Microsoft-Antispam-PRVS: <MWHPR12MB19505C646FA8F7AA28C2480DD9709@MWHPR12MB1950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zlhKyzHcFmaH4uL+YFYPazeV+iXOlTn1T+sXzsu9sS5m2KuJEqp5r43XpAbg0lk+ZZ1rYlI5bK9yrtV3fWuGywQcIVyIp5ZydUKSoTFOoG1F57dqU633INmO2VUwG6SF318HJMaGFhhir/NEj3viLxCq9y9Gm3IMCmcf8l8TfQP1mCpRBygfHyCGipMJ+5ufSQdVQNdjwspNdthkcaGKRAQYICrHFxqLQo3yL7dOgnTY22xnWyoKzwqcstRwdWrXpp4hIwtQHJZfEQjjPafDKXVowe3KPKrG8wWLbQDAys2UR0SykQjAirTugTzBbRn9YQeFxHSdnb8tR1yXPKKGE/ykzvWqSaAzB4gMvHLrDyIWyR0JVWBM5p1J/nmvBx6+Kqpf+iAqgwFyxtXjckkR8qNEnmrRJm2YBGH4C9QBW0Sl2caV9IqHSg33qz7Kn1Ai4JBnxFH8rns6Lzu5vt9AI7tkhnat6wywxBEmAeA7vBKlAfhU4tyNPWr2PaZwdT8JzYGnBP+GHzg7UiNtl3zExPmD4Gogd5cl9dCH3SzK640mN+Js5ZOmmRfFIqeNoPIqmyHbQtuPsqStDGBdtPu8TMLvTaJfczn15Fg2Kbt0OJdtn8mybusLfp30lwLidJKvsn2PcbX1DbzhykfKhDTax4nHKwor10SuOY1fWJy6Kmt4Q3WjU74qTZ0J5vfWl6P/
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(426003)(36860700001)(82740400003)(26005)(31696002)(336012)(186003)(2616005)(83380400001)(70586007)(54906003)(36756003)(86362001)(6916009)(316002)(7636003)(8676002)(31686004)(356005)(47076005)(53546011)(70206006)(478600001)(82310400003)(5660300002)(16576012)(2906002)(8936002)(16526019)(4326008)(36906005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 09:35:30.9567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4e1e3e-c9a4-4e20-6374-08d8fd965090
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1950
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 12/04/2021 08:52, Ulf Hansson wrote:
> On Wed, 7 Apr 2021 at 11:46, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> From: Aniruddha Tvs Rao <anrao@nvidia.com>
>>
>> CMD8 is not supported with Command Queue Enabled. Add required callback
>> to clear CQE_EN and CQE_INTR fields in the host controller register
>> before sending CMD8. Add corresponding callback in the CQHCI resume path
>> to re-enable CQE_EN and CQE_INTR fields.
>>
>> Reported-by: Kamal Mostafa <kamal@canonical.com>
>> Tested-by: Kamal Mostafa <kamal@canonical.com>
>> Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Applied for next, thanks!
> 
> Please tell, if you think this needs to be tagged for stable kernels
> as well (and if so, perhaps we can set a fixes tag as well?).

Thanks. We were talking about that. I believe that the callbacks were
only added in v5.10 and so that is the earliest we could apply. The most
logical fixes tag would be ...

Fixes: 3c4019f97978 ("mmc: tegra: HW Command Queue Support for Tegra SDMMC")

However, this does come before the support for the command queue callbacks.

I would like to get this into the v5.10 stable branch and I can either
send Greg a direct request once merged or we can tag for stable. Let me
know what you think.

Thanks
Jon

-- 
nvpublic
