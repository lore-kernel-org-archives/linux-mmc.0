Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034D2C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 07:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D946561ABD
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 07:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhKOHPG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 02:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhKOHMX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 02:12:23 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22B4C061746;
        Sun, 14 Nov 2021 23:09:28 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bk14so32954388oib.7;
        Sun, 14 Nov 2021 23:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4ODnEJjowecd7yqWRpehN0iPzgGiq8oGDsSH++GI2s=;
        b=C3zVhigno+aRneCu/clLZRU8PVrt9Ew/Ykbh4vxb/wYor5MNIbN+SO/i2aNcolWG6C
         Sc2i4Ki8e8MmEZnWLuHlt8DM7wSBi+bpnnFLdtRs9iEsFFL79Bn0T/oSa7fMItnosH7Z
         LWjqifeqvDMPoTRZdwPKgP6OmFF+xOsvKQVEtc54IyvpKB23S9KBpKuf22xKaucSFDi4
         ckmpF/beGMNfNt6XxY2E1USn6PP4porRnPJSBMbQqI/EKAhXxMKK8M+ATaUvzRwiLQ6p
         lurXkrjqKNj37iXN1QeoHgH02CoSD34w1d8VNlrRCNP8AYaQ5D0GE16rtsj7oFvS6q76
         iqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4ODnEJjowecd7yqWRpehN0iPzgGiq8oGDsSH++GI2s=;
        b=1RFex8KcRJT9OBniRxhAf6KDjuSlIQipexNeH3Wppot7OazMWs44OgZr3Zs9sT+MiH
         dfRY5LI0J0QLZb8AIVvMZ4gpcS8Vd343DO89G5GzXp36CEwYogdmhgjG1/tIB6MD3SI5
         l9rd5lkRNI/YPIhvRb4VrTOjo/gVuPTaZnMFbKSnegAqdEOO3poPH+k/LzzqiZ56K+e+
         xIx4z1jFDIzI8IAkXW6MX+NKvpcbHidvqqKxINTBHm2JrLbzoPB0eIuyVnKVfxPXiPP9
         9e4slYcBhwcSWmKVHZKl6vLkLBNeoFGjyIIlyv5N8HYplk8YFYy3KziTP5qVzvZ2Axc7
         qn0A==
X-Gm-Message-State: AOAM5326dnpoh6CttvwhqSmtd+qIA568Yu2EYGTocE0Jf5ykp5qtwXv/
        cP/FODLXM1yuNcWUEGamDrh0CAxz2xwi/INDzmM=
X-Google-Smtp-Source: ABdhPJwf5dgmjmpfLme7Gl4S1F6A+I4lA+bMShSszsLO4PbcnBl3X2dSlWPrfxxjI/TfnsL/5qAgi/JW1ptms6kIQP0=
X-Received: by 2002:a05:6808:d54:: with SMTP id w20mr30512951oik.91.1636960168207;
 Sun, 14 Nov 2021 23:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20211114204331.39555-1-huobean@gmail.com> <20211114204331.39555-2-huobean@gmail.com>
In-Reply-To: <20211114204331.39555-2-huobean@gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 15 Nov 2021 12:39:15 +0530
Message-ID: <CAHP4M8VAhcTysoBRfNQSiN3fTY6GK9fTz5+hzvzoEuNfC+9CHQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc-utils: Use memcpy instead of strncpy
To:     Bean Huo <huobean@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bean.

> -               strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
> +               memcpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
> +               lbuf[8] = '\0';

Above copies exactly 8 bytes, without any regard to the sizes of
destination-buffer (lbuf) or source-buffer (ext_csd). Thus, there are
high chances of overflow/underflow/out-of-bounds.

If ext_csd contains, say a string 5 characters long, you would want to
copy 6 characters (5 for length, 1 for null-terminator).

I guess you are trying to copy as-many-bytes as possible to lbuf,
including the null-character.
Thus, strlcpy/strscpy should be used here.

Something like :

strlcpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], sizeof(lbuf));
or
strscpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], sizeof(lbuf));

Note that you do not need to worry about putting the null-terminator.
strlcpy/strscpy already take care of that for you.


Thanks and Regards,
Ajay
