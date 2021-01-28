Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F1C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Jan 2021 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918AA64D9D
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Jan 2021 12:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhA1M3Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Jan 2021 07:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhA1M3M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2021 07:29:12 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642FDC061574
        for <linux-mmc@vger.kernel.org>; Thu, 28 Jan 2021 04:28:26 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id o12so3471181pfp.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Jan 2021 04:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=KQRxmbkqnVfcFdMWoNI1FcaCAHf3VakR0zyATmOVZLg=;
        b=NiEN2RXjNnyyA1aD6pItplvLFhcRqc0fl33qILL57dK8zoOLNNTnP9UJhpZPPhptgz
         TDyuuRWmiCn4UDZ3P8NxBR1dCQwWvRwxYXDUx4Gk0cfn2ANsgZ1r5SVftz8ZnU+Ubnke
         UXp2FTqwKUbv6dyU1fv1WhpWaV4LLFTzYWtxk3iJJt3eYHQux8BiuhlGGGp7+OjusUUx
         e2OpJMrr6dZM8Q2Z44EmGpFlBZmbKEOa172YWfMvnFeLIIC2VHWpmVjzjru3TvvH+SkC
         cQo1+6Z+Q84/bSj1JNMb66n7OV2UMv/4pv+RVlx1u4LrCMfMEWUcoOl6y1SC3nrJuJ2c
         wTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=KQRxmbkqnVfcFdMWoNI1FcaCAHf3VakR0zyATmOVZLg=;
        b=CzFgGv+xj8bSQ92SeMAC54SBPDzsLbeRUyqphe8CApGwweA7IJST4DbuAsLsujwyZr
         jkKomINyfCJnGmlPiVG+DTC/7slx2r7QPiANw2zbcL0LAniDrg8xE/sse4iRSB/0mcZL
         d+tUdYktkqlNizrDw8MrZQtZWLN9gV6AvFaaeDzIRatG0QxQYArdZ3VGGxWuaGv4xQUo
         OVu1zpJqBQ/zzKCpzbuiFSjU0sozxKg9fFfWXpcn3GjaC8kT6EcE3aq0NE593on6F8ba
         El30kQJXd74jN4Rbdi11S+8BsIyf1/YREOl+2MBBejg09eknW5AgsBrJzdHq5zzhyLXG
         Q/eQ==
X-Gm-Message-State: AOAM531yrp2M2Ut6woVfycj3yc7Optwg6mXIgQQC1UujgohBo/T82SxU
        jBajSKyou4y09ZXoWasELM/cj/8Q8lMIpi43
X-Google-Smtp-Source: ABdhPJzHPUJozEO9IhoK+J+fdPwIzudsS5MDpsiCcLzp30hVMfgHC1ekwqAWwALMnAPFd5DnNYROM+fFEfzz1YpP
Sender: "victording via sendgmr" <victording@victording.c.googlers.com>
X-Received: from victording.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:65c7])
 (user=victording job=sendgmr) by 2002:a17:902:b212:b029:df:ec2e:6a1f with
 SMTP id t18-20020a170902b212b02900dfec2e6a1fmr16016023plr.24.1611836905911;
 Thu, 28 Jan 2021 04:28:25 -0800 (PST)
Date:   Thu, 28 Jan 2021 12:27:54 +0000
Message-Id: <20210128122311.1.I42c1001f8b0eaac973a99e1e5c2170788ee36c9c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] PCI/ASPM: Disable ASPM when save/restore PCI state
From:   Victor Ding <victording@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Ding <victording@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Certain PCIe devices (e.g. GL9750) have high penalties (e.g. high Port
T_POWER_ON) when exiting L1 but enter L1 aggressively. As a result,
such devices enter and exit L1 frequently during pci_save_state and
pci_restore_state; eventually causing poor suspend/resume performance.

Based on the observation that PCI accesses dominance pci_save_state/
pci_restore_state plus these accesses are fairly close to each other, the
actual time the device could stay in low power states is negligible.
Therefore, the little power-saving benefit from ASPM during suspend/resume
does not overweight the performance degradation caused by high L1 exit
penalties.

Therefore, this patch proposes to disable ASPM during a suspend/resume
process.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211187
Signed-off-by: Victor Ding <victording@google.com>

---

 drivers/pci/pci.c       | 18 +++++++++++++++---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/aspm.c | 26 ++++++++++++++++++++++++++
 include/linux/pci.h     |  1 +
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 32011b7b4c04..a925a7075063 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1542,6 +1542,10 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
 int pci_save_state(struct pci_dev *dev)
 {
 	int i;
+
+	pcie_save_aspm_control(dev);
+	pcie_disable_aspm(dev);
+
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++) {
 		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
@@ -1552,18 +1556,22 @@ int pci_save_state(struct pci_dev *dev)
 
 	i = pci_save_pcie_state(dev);
 	if (i != 0)
-		return i;
+		goto Exit;
 
 	i = pci_save_pcix_state(dev);
 	if (i != 0)
-		return i;
+		goto Exit;
 
 	pci_save_ltr_state(dev);
 	pci_save_aspm_l1ss_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
-	return pci_save_vc_state(dev);
+	i = pci_save_vc_state(dev);
+
+Exit:
+	pcie_restore_aspm_control(dev);
+	return i;
 }
 EXPORT_SYMBOL(pci_save_state);
 
@@ -1661,6 +1669,8 @@ void pci_restore_state(struct pci_dev *dev)
 	if (!dev->state_saved)
 		return;
 
+	pcie_disable_aspm(dev);
+
 	/*
 	 * Restore max latencies (in the LTR capability) before enabling
 	 * LTR itself (in the PCIe capability).
@@ -1689,6 +1699,8 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_enable_acs(dev);
 	pci_restore_iov_state(dev);
 
+	pcie_restore_aspm_control(dev);
+
 	dev->state_saved = false;
 }
 EXPORT_SYMBOL(pci_restore_state);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a81459159f6d..e074a0cbe73c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -584,6 +584,9 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 void pci_save_aspm_l1ss_state(struct pci_dev *dev);
 void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
+void pcie_save_aspm_control(struct pci_dev *dev);
+void pcie_restore_aspm_control(struct pci_dev *dev);
+void pcie_disable_aspm(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
@@ -591,6 +594,9 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
 static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
+static inline void pcie_save_aspm_control(struct pci_dev *dev) { }
+static inline void pcie_restore_aspm_control(struct pci_dev *dev) { }
+static inline void pcie_disable_aspm(struct pci_dev *pdev) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a08e7d6dc248..519b9f1b067a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -105,6 +105,12 @@ static const char *policy_str[] = {
 
 #define LINK_RETRAIN_TIMEOUT HZ
 
+void pcie_disable_aspm(struct pci_dev *pdev)
+{
+	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
+						PCI_EXP_LNKCTL_ASPMC, 0);
+}
+
 static int policy_to_aspm_state(struct pcie_link_state *link)
 {
 	switch (aspm_policy) {
@@ -680,6 +686,26 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 }
 
+void pcie_save_aspm_control(struct pci_dev *dev)
+{
+	u16 lnkctl;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	pci_read_config_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+	dev->saved_aspm_ctl = lnkctl & PCI_EXP_LNKCTL_ASPMC;
+}
+
+void pcie_restore_aspm_control(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return;
+
+	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
+					PCI_EXP_LNKCTL_ASPMC, dev->saved_aspm_ctl);
+}
+
 /* Configure the ASPM L1 substates */
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b32126d26997..a21bfd6e3f89 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -387,6 +387,7 @@ struct pci_dev {
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
 	u16		l1ss;		/* L1SS Capability pointer */
+	u16		saved_aspm_ctl; /* ASPM Control saved at suspend time */
 #endif
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
-- 
2.30.0.280.ga3ce27912f-goog

