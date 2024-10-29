Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E497206047
	for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207881; cv=none; b=rJZhhBBpHw75jwdegM6Zs6SNdv7XvGTe7Z0XZmNTNYpFRBVfy1pvG2f08L8t8jzQP15fp2LRxq67gX48LFdBwldkUoos0W+hzj3tOMmSGpA2QDYxIXfypRU9IznLfIm+GNlpBmnkPzv95D140IvVUqV5af+xqrf/R6OlVvCg860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207881; c=relaxed/simple;
	bh=jLhj/ex+QixSb5i4w3Tt6w0jRciwP4qE1O0l1pqDbdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6dVNgGRVpxXY5LR7Bc7fBHZHvsZ8YnMKQSeTnJIFt4kUZHApFn0Hrz2EeSRuzED6QLRLnXwheezLSDzRWSS/A7uTysmgm4GaXfT5k5LvoocOEG2eM35JI4LwCEXnqvsQoribTXzx5nDdnLeCv7sU3cKkiN37P/+tot70jwL4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y77L6Joq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y77L6Joq"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5743074bso44423271fa.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2024 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730207877; x=1730812677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1N+vVVBQWYgpIJyhvHjDiFW5w7UYJ9BQQQxmwzMHM80=;
        b=Y77L6JoqZVjEWEtTYjj2YTmCtLr4r+VuKJNbfQZL5pGiahhYIAmRSxQ6KfY+WW8dB7
         QwsYNCvW+xSSoVk2XnHqnNtKrMMe2Y2jQ0RIGtZstpX6Hc35B5lfVg9gfjyyWAUxGZFG
         IhhdySVzDZRqPZjJH11+fyaHxEZ4FgBKOL5id/ccHS2pUf88sgW7bm4WIJgz+f4xFlMI
         O/UcmmDkd+rdeNBa5d15trRz5n0BnYHiqZuHRcHLLVBHq3hA8zKw5mHXDT1VdshpQ4SD
         DjnYeTRUubXuWYteOjGl5rJD6p/JpzdZIjULgdCVBUp0YCPuQWpiIk1k6xT596kA9Rhx
         B++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207877; x=1730812677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1N+vVVBQWYgpIJyhvHjDiFW5w7UYJ9BQQQxmwzMHM80=;
        b=Bo8zQnZKTm+T8XaPuHpeBB7yAdklftHpBvp+QogeXDWsQDgn8KoJ7KYYTox/LGeg3z
         xSZZ6wjxE82Qc56ma5j9o6Dn1sLS6lGAj7dGtjD60TX+5IPoOiPkc1+I2kzmgv4Duj0x
         ukdgwPX2O9QbogNEs3LJdSztIW2Rg3A+Tkp08ndssei30rKevJVtLZChKYIMwY9v8PQ7
         zvdvtUOsTy3Ks/YDbSJe2RuQs2v9bUy8ausS+1OE5jpLCDHdFI1STmXDs5EOvpDC9cv4
         NpNNkYVZ+MG7JQrJcbPRWIf+drJC2WWMu8cC28sM1sCJ5E0Rc64AaL/Mcucf7xVKKE5O
         cT5w==
X-Gm-Message-State: AOJu0YwfbH3bmCL+h6xW830sbeiMwwvvOzuk1SMopSxFjsVpjLcNhfp1
	tkAOjUWut5sbLr+bByp5Niio9BSgSwAFGiMARh3IBZr7BX3aZ/93F6xXKfd0yYFkZI/JQv+r4c2
	i
X-Google-Smtp-Source: AGHT+IE5RkhoPl4UK1lubh0oY1lGyCltRVJ8yBpNvSjZBTTKrUGFH8tKo8+D0eV+y9T8vsN+I18VNg==
X-Received: by 2002:a05:651c:1545:b0:2fb:3881:35be with SMTP id 38308e7fff4ca-2fcdc920ea2mr7062221fa.9.1730207877490;
        Tue, 29 Oct 2024 06:17:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d1b5asm14898401fa.85.2024.10.29.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:17:56 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Victor Shih <victorshihgli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: core: A couple of fixes for UHS-II card
Date: Tue, 29 Oct 2024 14:17:46 +0100
Message-ID: <20241029131752.226764-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recently introduced UHS-II support to the mmc core has a few problems,
during the card initialization and re-initialization. This series intends to
addresses some these problems.

Ulf Hansson (3):
  mmc: core: Simplify sd_uhs2_power_up()
  mmc: core: Add error handling of sd_uhs2_power_up()
  mmc: core: Fix error paths for UHS-II card init and re-init

 drivers/mmc/core/sd_uhs2.c | 65 +++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

-- 
2.43.0

