Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BD2C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA8161052
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 12:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhI0Mwf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:52:35 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46126
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234455AbhI0Mwc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 08:52:32 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 140CA40816
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747052;
        bh=kbXZWPaqkE+qi2UkSZceVKtKOIxxsWqidwnT9f4+61Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GWdLsZgzrhZ3S+Dm9xPuyEGepjLZz058w3zuCjtM9L7IG6v5NnyG5mVYAdAYqq4XU
         PFazH1K3fB36Qu18CdR765IPVzqSAy/tOkhhARhH9+ZIsjooYMwsoASZ7umP6rczss
         7VG4IGiFzc6/eqYEjAq8o8kiX0aSgCD8l2Bfuje01xOVnyqV3simJ4PM10tlIIXW8L
         4tkkwiNIZbT7iQFfmQKQnYK9ushiolXqhNLKS/IlNkq+3dbk1Mj7T4euaVn+8LOVS4
         er5oGU7QONDYOrgJiIfo6M97ep5w8EHoPUXKHdbVisFJkI2zBYr4Gu3mcuk6T3ErWS
         eODtSUHH+SBQA==
Received: by mail-lf1-f69.google.com with SMTP id m2-20020ac24ac2000000b003f524eae63eso15812068lfp.10
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 05:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbXZWPaqkE+qi2UkSZceVKtKOIxxsWqidwnT9f4+61Y=;
        b=JxAl6E5ByblDPtB7DVdfpwyoOgULQ6cW/F4PccBgU24wlCxTaHS7gvpB1FzQyb5T0P
         xwrEDDiytdSh5/mFf4XmGjOIBpgRAXD5jDZVYyc3P2NQNoEfE1GK992ajbWr5az33qaP
         NZQ4osIzNiNcdjSKyDopuhP/idXCxxDtjK42UwkKhX/8oXUoIc9D+QYvZymb1Ay/+/Eh
         SPFVLnzTnK/WfWualVOOltdGDY8ToOfkk27SoFsc/JBSfkzh+1DTAHEhEVewGIKlqKXF
         NWFoDJ1FtL9Yf4/wbpEHDJf2n8i6CKUnD3h8FRXn4tFFFQA3psfFWgW8M+UqYT0kwQFC
         73AQ==
X-Gm-Message-State: AOAM532pABPghVCeFQmvdS8MTPcKomxRp1e5kMzX0hUT7347nhIgotsz
        o1LWQETzREm8yymuAErS7PdSTzMicIKFl4hw8Nj5dRB6qAuetK+q9iWEnmWbnOZqSbKM6ycQiz+
        Zh8sgBJ3ze4iSI0dsYQ+5n5yf8P8V3K4gMnDtoA==
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr25204262lfp.647.1632747051399;
        Mon, 27 Sep 2021 05:50:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMaM9Tc/3Sf/+ppdhry9L6l8UQ0qQ8h8nkUrM4xE3wk1hVkdcDG25FWuf57DjlukjnWtXjcQ==
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr25204228lfp.647.1632747051152;
        Mon, 27 Sep 2021 05:50:51 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 3/6] riscv: dts: microchip: fix board compatible
Date:   Mon, 27 Sep 2021 14:50:41 +0200
Message-Id: <20210927125044.20046-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to bindings, the compatible must include microchip,mpfs.  This
fixes dtbs_check warning:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: /: compatible: ['microchip,mpfs-icicle-kit'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes since v3:
1. Rename DTSI model to Polarfire SoC.
2. Add tags.

Changes since v1:
1. Use microchip,mpfs for microchip-mpfs.dtsi, suggested by Geert.
---
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 2 +-
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 3b04ef17e8da..07f1f3cab686 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
-	compatible = "microchip,mpfs-icicle-kit";
+	compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";
 
 	aliases {
 		ethernet0 = &emac1;
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 93730afe6c58..1d04c661bccf 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -6,8 +6,8 @@
 / {
 	#address-cells = <2>;
 	#size-cells = <2>;
-	model = "Microchip MPFS Icicle Kit";
-	compatible = "microchip,mpfs-icicle-kit";
+	model = "Microchip PolarFire SoC";
+	compatible = "microchip,mpfs";
 
 	chosen {
 	};
-- 
2.30.2

