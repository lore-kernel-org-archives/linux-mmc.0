Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C24BC56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C287621D46
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 11:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dtml1lVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbgKZLQT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 06:16:19 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:56520
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727498AbgKZLQT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 06:16:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KakCYAtvvufnTwbbo6ilZkt3silRz2OoN8nB6Cwpqn4bI2GBHLj5A0AHIKEOMDRBHvbo41AXZRAlcx/NTYYQdJsey8uW0cIP/0+DWxUHWTsHWsNn6kxirIr/1NHP70BNCw4GWAnIiI1QGZehYgyV0n3LL8mIlg0CC42A1ouinpwvNi3IsnvgR6d8L+bmookJnGIB37HzdNJz2d4HvMoYeLEBXBWYW31x28N/MrPSLSMTuypx2lukJxYNNtK1rS/WZj15s+JfQQ4u9VMYdAPFFLBkpIxfA55dXfKUn/W+XSP0m3Uxezj+yI2KCgnCPHdyG1bUHVDfwxYmqTZfcuQ3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMLgyjwgLFAQgzIYIDZH/IRCvx/4B/zeLEgtbddHoZA=;
 b=iHqq2isu66VCyFwKM7kvQta30qBFxyIsAg8ySQM6JUxhq+RGSVerBxVA3FenU6VyJMHHnUQlRUdKfsX5LPSqQ9hyvDvadHR/MRbX649joWlTDh1+jz4785C7j49sPflXH79YOYl0o7WMsPpVKUcNyyf5Dy53gVOth9ibjnef0oQxMX2PdBHMNwT7FEGhxf55Db5BrCTYUMtARkK+O97D74lLXbnsRl8XVWKGEmW4fpXVENBVB6SfIoDKDYxqFsdiUOeqV0iqB2qECWwhNUvI4Tfimwl3v9s/N5/v33q5PcMXrjiwwr85cNyRCpTfx0FlJW8DiejCOlVratCuMhZZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMLgyjwgLFAQgzIYIDZH/IRCvx/4B/zeLEgtbddHoZA=;
 b=Dtml1lVXMpSyvOzpZvFsq3+9KUqdb64U8QBnBBfieWZTysBHBYDU60WO/SgZPiVsbOc4VBvBifbSKVFwpnQoa9WN1Y7lADCA2ap1jKlV8alONlYLQAIf7Ar17XZGBQUE2t2CghYJcuZQeruK84zHVWGqSLcEz9u3NJGILa/kkPY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 11:16:16 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3611.025; Thu, 26 Nov 2020
 11:16:16 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND v4 00/18] arm64: dts: imx8: architecture improvement and adding imx8qm support
Date:   Thu, 26 Nov 2020 18:58:42 +0800
Message-Id: <20201126105900.26658-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0160.apcprd03.prod.outlook.com
 (2603:1096:4:c9::15) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.7 via Frontend Transport; Thu, 26 Nov 2020 11:16:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81f99ea1-e1ad-47f4-2aa7-08d891fcb0bf
X-MS-TrafficTypeDiagnostic: AM7PR04MB6869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB686906DB0433E6DB357D0B1480F90@AM7PR04MB6869.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YOwbahcKIQVdUb1K0W6z/JWcobU1lyqve3TFMm3RPKSwZA5dxhE+wCU8HYJgN+DanS78QXWvTQkcEOkeEPCj9MjzQfQ6LtTb/hVBlIAL/edh3byXU1QTEyPEW1yE/nhlekIcz+7PAQTV2FBkyz7lCHxzV9CgTEFKpgS8lEpTmTotSmzH35ZPC6GX4qAkgnUG6IC1V8cyZbDcQVliXJQmd0PAO50RoTvEv+p4b/m6VUd1xpz2Q3owJFXQd3IB/E7EWvFrSsRsDiqu2f05BJ5z3tkLGK5Sye6ON5Xyg7PD8k7rhZk95gybBNrRtY2Isb7Fm7K0aBaf1UyY9eMlSRzsLqcGyzyfaN37p7QN5nwqFjC/GD4+oWicK1XZmNdkf/L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(6916009)(4326008)(478600001)(6506007)(316002)(956004)(8936002)(8676002)(6486002)(2616005)(6512007)(16526019)(83380400001)(186003)(86362001)(66946007)(36756003)(1076003)(66556008)(2906002)(52116002)(5660300002)(6666004)(26005)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HEnq/2OOhPNaDoS75dHKvCY21P4bqS/DiN6PBorlsf7BOjeXfeE42e1Lw/TDevPoAJQop3dbh1THSXzz17sOnTk65pczaUBh094QbDe5w5JfnzKPJMONwltEi4vphcT6sOV7jWMPdwZ8Ofbxx8ZcPtUs83O/bJi8UOCwbfRTiPujerQAo6FG/EmisNxsMam5UMw+oQo+IJIbIgLA1Ezrnhgad7WY6rka4RSvxLpA/tU9NnD0O24o06SdRBHeIYn4p9XtcY8PIUPllFbDBylzJiTuO1+TdqVM8LMEeS1GBVbvX6+qXxSFvDyRnNHLD6vJv/XnYelX5oOcrVmXCGW7BVXXY563/zOiNv/w56S52J9WbgyrRaqplriTNq4nTMaEPQl2gWtPHb73kks9B8zKJ6FGH3sTgUM47qxVgjDbj764a9gBK/qCsYlp5P04YwoPx176SUDIhjeVYyrYuJoL7xpFFUQ759aHe0zl7Ge9ogoSEHM1Nvn3Qr8lH9g0DW+BG2HH5IhZBFi6rmvsmKR8OAvD1A92LVgZgpc75vO8H+7WtC9krLxzjFNestt1P+qWmw6s/imz1gBtnuUdn6qhz6TR4WFt+vcF7qtrZYYhbzr0j60z8hMpOdVaNLspgVEvkJlFD5b1VVqsL4WXVGokYeyrcmujs9SWgh7x1HTlOxo/uTKo/hTUdXn8PlmmXku/TcfZjXyDFoYkuiK+/r3D/58P0VwGEEXWjiHbdRKce4YJ/B8N40fFvozkLgFkwP3oKhz8ZEpn+Uwu2JREesIZ6RK4T9JNgqNMfSJwUumA/S/csnTL/UMrfBS+NDi9CKZ63R2I71agnQHNb+CRvFXPsdHZLcmQ0Bqhxd8uVf53ntbh9D9Tax2y0RP4pHzDq6EDiQcrlrc2gEc+sKYU9jWO2g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f99ea1-e1ad-47f4-2aa7-08d891fcb0bf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 11:16:15.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKtSObOyTJNBm98w5uO7aiftaGoToX1wmsW3Mvbz+B53bIZF3TFQp/hMsY7VaR6GfWYpux3mPL9GRPOx9TEv7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

IMX SCU based platforms (e.g. MX8QM/MX8QXP) are comprised of a number of SS
(Subsystems), those SS may be shared between different SoCs while most of them
can be reused like Devices Resources, Clocks, Power domains and etc.

This patch series aims to improve the MX8 architecture to comply with the HW
design to save a lot of duplicated codes and benefits us a better
maintainability and scalability in the future.

ChangeLog:
v4-resend:
 * no change except put three module binding patches first which are used
   by this patchset.
v3->v4:
 * mainly rebase to latest kernel except a few very minor changes like change to use
   new scu protocol binding which was not supported in last version
v2->v3:
 * use clock-indices property instead of bit-offset property suggested by Shawn Guo
 * rebase to latest shawn/for-next
v1->v2:
 * change to the new two cells scu clock binding, so original adding scu clocks
   patches were removed.
 * Move scu pd node above clk node


Dong Aisheng (18):
  dt-bindings: mmc: imx: fix the wrongly dropped imx8qm compatible
    string
  dt-bindings: arm: fsl: add imx8qm boards compatible string
  dt-bindings: mailbox: mu: add imx8qm support
  arm64: dts: imx8qxp: add fallback compatible string for scu pd
  arm64: dts: imx8qxp: move scu pd node before scu clock node
  arm64: dts: imx8qxp: orginize dts in subsystems
  arm64: dts: imx8: add lsio lpcg clocks
  arm64: dts: imx8: add conn lpcg clocks
  arm64: dts: imx8: add adma lpcg clocks
  arm64: dts: imx8: switch to two cell scu clock binding
  arm64: dts: imx8: switch to new lpcg clock binding
  arm64: dts: imx8qm: add lsio ss support
  arm64: dts: imx8qm: add conn ss support
  arm64: dts: imx8: split adma ss into dma and audio ss
  arm64: dts: imx8qm: add dma ss support
  arm64: dts: imx: add imx8qm common dts file
  arm64: dts: imx: add imx8qm mek support
  arm64: defconfig: add imx8qm mek support

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../devicetree/bindings/mailbox/fsl,mu.yaml   |   5 +-
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8-ss-adma.dtsi      |   8 +
 .../boot/dts/freescale/imx8-ss-audio.dtsi     |  68 +++
 .../boot/dts/freescale/imx8-ss-conn.dtsi      | 184 ++++++++
 .../arm64/boot/dts/freescale/imx8-ss-ddr.dtsi |  18 +
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 202 +++++++++
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      | 311 +++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 144 ++++++
 .../boot/dts/freescale/imx8qm-ss-conn.dtsi    |  21 +
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     |  51 +++
 .../boot/dts/freescale/imx8qm-ss-lsio.dtsi    |  61 +++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     | 176 ++++++++
 .../boot/dts/freescale/imx8qxp-ai_ml.dts      |  20 +-
 .../freescale/imx8qxp-colibri-eval-v3.dtsi    |   8 +-
 .../boot/dts/freescale/imx8qxp-colibri.dtsi   |  12 +-
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  50 +--
 .../boot/dts/freescale/imx8qxp-ss-adma.dtsi   |  37 ++
 .../boot/dts/freescale/imx8qxp-ss-conn.dtsi   |  25 ++
 .../boot/dts/freescale/imx8qxp-ss-lsio.dtsi   |  61 +++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 423 ++----------------
 arch/arm64/configs/defconfig                  |   1 +
 24 files changed, 1455 insertions(+), 439 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-lsio.dtsi

-- 
2.23.0

