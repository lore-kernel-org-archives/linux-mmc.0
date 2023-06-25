Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A15EB64DC
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jun 2023 10:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFYKi1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jun 2023 06:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYKi0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Jun 2023 06:38:26 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E250E44
        for <linux-mmc@vger.kernel.org>; Sun, 25 Jun 2023 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687689506; x=1719225506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SnCDPzIBMA29R0QcKEdlu1D5QY0YLYKcPEZbvfxludI=;
  b=Uke7ej9KQ5cJKl2fayhRGiruETRgtO+/vVppWFu4Fb/Mt0kAAz7uFVNI
   C+7eNH2EerWrIrIYFtEh+SmbRl5IkUD9sYRgPlUReQ9zc7b0RlVeNCuIK
   EdzrQNdZDR8am65F+fVNIyLFaOFBcTglfznCcAfB6SVwnFhpH0QivSfM3
   XDymt/WBRMGYj4/rIUOoM3wze26YiB3nL+xkkctePyUXympkNLZDS2amP
   sPfbj8so85iJmw9phmm1jPFawZcnjUe0dOdl3vbCAJn1voJJX+WRutRYF
   i34tZ4mPPEdEBvity5iLxa74gAALsQXCbjTl9InlBso4Ws+fZOYF9tD0W
   g==;
X-IronPort-AV: E=Sophos;i="6.01,157,1684771200"; 
   d="scan'208";a="236159309"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2023 18:38:26 +0800
IronPort-SDR: OCtglKiLConCEaBDFXhOqBlvaQLNtCdzxiIrrpd/5BE/eGhbHySB+Z+i+xheNp4pI0yXOg9VeT
 HRv9YpC6rh3YmYS1+btoJAuWe3/Wh9IFb7LJ3nI7P44Abph/K0jHQoty2+R0D1524yJy3Rynbq
 7KX54zlWYU/sKyIGFZnUVepJp4/uCtDvkq0duAoKWeZrx7avrgNMkTvDWoEjtYZIDj7rEC2z9z
 haDu1yrPTpq2qEQ7IrsiZxBeAiK/+Oo++RHDWR47Ba/oqva49WPWp80ZwZ5KtEXufFcs/+59Ho
 FBE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2023 02:52:46 -0700
IronPort-SDR: ka7UT6kUUQt/0XrNvmmNNMu94h+Qz3cEQyY9N8wT3J/wCOLGQCQgLpI4SMeAfSE5UpVNaTrZFn
 n8mLYwcZKCNx33lpmqVPgb+9Zi+bHH59dhArkb45t9md15Tw0WDeVCu5JkJP4GG83c2n8vSBlS
 /cyUHOpUxBvYJO51cTR7xwklTcertweG78U6wW/o5Q9Tzms02ra7atTYZn1Y4CzH/thpM77s2U
 fgXcLbQPKZba8DNeQhLiAbQnG0l6ntC4oaTco+9XizKH3Sem6ouGTYuWUoe3UlpSHoBn9WAMz/
 qZI=
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2023 03:38:24 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/6] mmc-utils: ffu: ffu of large images
Date:   Sun, 25 Jun 2023 13:38:08 +0300
Message-Id: <20230625103814.105-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

ffu is done using a single multi-ioctl to carry the entire firmware
image. This is limiting the fw image size to be at most 512KB, as the
mmc driver restricts each single ioc data to be at most
MMC_IOC_MAX_BYTES.

The spec however, allows the fw image to be written using multiple write
commands. So if the fw image is larger than 512KB, split it into a
series of smaller chunks.

Avri Altman (6):
  mmc-utils: Add fill_switch_cmd handler
  mmc-utils: Add arg argument to set_single_cmd
  mmc-utils: ffu: Simplify ext_csd bytes parsing
  mmc-utils: ffu: Add ffu multi-command set handler
  mmc-utils: ffu: Allow ffu of large images
  mmc-utils: ffu: Add optional chunk-size argument

 mmc.c      |   6 +-
 mmc_cmds.c | 161 +++++++++++++++++++++++++++--------------------------
 2 files changed, 86 insertions(+), 81 deletions(-)

-- 
2.40.1

