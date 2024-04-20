Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD357625
	for <linux-mmc@vger.kernel.org>; Sat, 20 Apr 2024 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713582905; cv=none; b=FMJzhaTCHJd5emHY9OwcO2/MMUdewGY6KWaHmn1dABY7GtQtaOQc5cwVoq0hdQN8lPOSNyT43U8CoVaxBDgykHsWStSXf3nY28Y7tWSmzxCEPLGRwRZ1NGHQbPCTFHChuAy+Pn3USqxp+OfQH2D6KGgV2r7T+722+cbf3Ic0++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713582905; c=relaxed/simple;
	bh=DpBm8PfBIfjsF3qa5TDyJENVA7c8i6H5hq3Uye6mumY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WuiKCnWm77UV7cdMdgenMlucCjt/l7idFpAaJhBFJ5Q5KnUm8mYGJAvljiq9H8xmHIXM1ao6WoC24CRI48qhllMs6cRr1uQw47qRLCZozEkKOIAFhzmUmET0CwwgvEnFZdx89POujkTejGCITPazxw9bambE5HeRHAMNu7W8V80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdnMMyUF; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdnMMyUF"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-238fd648224so1388561fac.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 Apr 2024 20:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713582902; x=1714187702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Flcg6riqC/Et/prq76MPGW31K0079MYubQPPOvdUlE=;
        b=VdnMMyUFkN/QZ8Em2/e8nK5ohG9hpaloDDo0nctZoFjcFHNfzO2aZw5NhgaMH9Ol/u
         IgbHJEpw9LVYG+UmDDpdx8LTZzJOtjsS66B4RlwD7WMb96wlX2AD11uriiQD7UW1RQ91
         ZAuvOcmAE9IptDYGy6s1pNKOuSPb5CWSNhJvG8B7OR5nEPOrXnrY9aja6PIPsCwGbW71
         oDDShRfe5lYate2chRwK4Bfm0D1s8K+A3wiGRZPVFtLg1EU+vk0GBOJmNqs4Yxw9Jjnw
         5f/bLJ3Bjh2MckA5+RADQGF1vdTW1Qzy1qn22LVZ5ABuxWXPe43/oqKkbpNMfvDTDkiq
         G11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713582902; x=1714187702;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Flcg6riqC/Et/prq76MPGW31K0079MYubQPPOvdUlE=;
        b=GXrytdSstZt1alvQJ7Usx8amY7s6qs4TDrNOf8Sstg6BcuYn5wrnrk1Jv/o2/fjpEj
         7lRi+BpB3RFkB0wmzy5tMOIWzrSOO07a6kCj+KC6x4IWJfXU0MAQvw2Nzk0UArO04ZQ6
         Q9NzOdyuDgTlMFf08Nz0D1Nqu28y4XNoXrlx+dlOinyzp4Ek6wMtIGSkDZfb5f9PHqTo
         cTykKDQs4zENPsLuNDlw3dcsiacWq+8Q58YtWexERjkdn3vIrJluxGJyeOMFAwuxku2Y
         Uh/Ipua9NfdKfAXHTkflMPuN+UTtu1XwVHHVO/vqHUhBjuWD9BMZtw4Q+5bOKNt5SiN2
         T2ig==
X-Gm-Message-State: AOJu0Yx0ic2DReseBKe2kyf/1u5/AyLTn+HtgHyojDR4krUYy7qojxag
	21u/gU71YInU0swC/AM5Ta2JgWwWO2reII5K3ZSJBRhDvS1R5aHp45bWYrP7RSc3jzOIl7K/Bii
	umBVZ6wDAtkN+dmfH9xbpd1ScMYM6T+mm
X-Google-Smtp-Source: AGHT+IEVrs1cFcoCpCKCeviHjVAYa6AZRXi2nE6D68ffzcs5DzyTF02GnrcMJTCKlQrWyuo7XCUGK531/3Cu2hFAUvA=
X-Received: by 2002:a05:6870:4592:b0:229:ec0e:7348 with SMTP id
 y18-20020a056870459200b00229ec0e7348mr4959326oao.46.1713582902401; Fri, 19
 Apr 2024 20:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhan Liu <liuzhanjobs@gmail.com>
Date: Fri, 19 Apr 2024 20:14:26 -0700
Message-ID: <CABqN7BxTNMFz5hxPePYV0sM02XwRsv+g7Siw-ZKZ7_X++H0JtQ@mail.gmail.com>
Subject: [PATCH v1] mmc-utils: FFU Status check for device without FW install support
To: linux-mmc@vger.kernel.org
Cc: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

 [PATCH v1] mmc-utils: FFU Status check for device without FW install support

From: Zhan Liu <liuzhanjobs@gmail.com>

Problem and my changes

               ffu:also check ffu status for FW install not support
device to catch the possible error of FW download error
(FFU_STATUS[0x26] = 0x12), which is not captured by current mmc-utils.
current mmc-utils simple ask user to reboot, which give the user false
impression that the FW update is successful. they will only found it
is not after they check the FW version with extcsd read command and
have not idea what is wrong since at this time the FFU_STATUS has been
reset to 0x00. With this patch, user will know that FW download is
failed.

when check the devce don't support FW install, read extcsd and check
the FFU_STATUS value. If it is 0x00, ask user to reboot. If not, print
the error message and exit.



---

Signed-off-by:  Zhan Liu <liuzhanjobs@gmail.com>

---

diff --git a/mmc.h b/mmc.h

index 6f1bf3e..5b06410 100644

--- a/mmc.h

+++ b/mmc.h

@@ -229,6 +229,14 @@

#define EXT_CSD_SEC_GB_CL_EN                         (1<<4)

#define EXT_CSD_SEC_ER_EN                  (1<<0)



+/*

+ * FFU status definition

+ */

+#define EXT_CSD_FFU_SUCCESS
             (0x00)

+#define EXT_CSD_FFU_GENERAL_ERROR                                        (0x10)

+#define EXT_CSD_FFU_FIWMWARE_INSTALL_ERROR                   (0x11)

+#define EXT_CSD_FFU_FIWMWARE_DOWNLOAD_ERROR                         (0x12)

+



 /* From kernel linux/mmc/core.h */

#define MMC_RSP_NONE          0
 /* no response */

diff --git a/mmc_cmds.c b/mmc_cmds.c

index 936e0c5..10bdb94 100644

--- a/mmc_cmds.c

+++ b/mmc_cmds.c

@@ -2962,9 +2962,38 @@ do_retry:

              * if not then skip checking number of sectors programmed
after install

              */

             if (!ext_csd[EXT_CSD_FFU_FEATURES]) {

-                           fprintf(stderr, "Please reboot to complete
firmware installation on %s\n", device);

-                           ret = 0;

-                           goto out;

+                           ret = read_extcsd(dev_fd, ext_csd); //get
the current extcsd after FW download

+                           if (ret) {

+                                         fprintf(stderr, "Could not
read EXT_CSD from %s\n", device);

+                                         goto out;

+                           }

+

+                           switch (ext_csd[EXT_CSD_FFU_STATUS]) {

+                           case EXT_CSD_FFU_SUCCESS:

+                                         fprintf(stderr, "Please
reboot to complete firmware installation on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+

+                           case EXT_CSD_FFU_GENERAL_ERROR:

+                                         fprintf(stderr, "FFU General
Error on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+

+                           case EXT_CSD_FFU_FIWMWARE_INSTALL_ERROR:
//may never happen since we have not install firmware

+                                         fprintf(stderr, "FFU Install
Error on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+

+                           case EXT_CSD_FFU_FIWMWARE_DOWNLOAD_ERROR:
//main purpose is to check this since it will be cleared after power
cycle

+                                         fprintf(stderr, "FFU FW
Download Error on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+

+                           default:

+                                         fprintf(stderr, "Unknown FFU
Status on %s\n", device);

+                                         ret = 0;

+                                         goto out;

+                           }

             }



              ret = read_extcsd(dev_fd, ext_csd);
