Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19E233952
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466842; cv=none; b=Y6OnK5bk9IeShcBaZxEZ8UlVMFMikL3/Gnc4+lbB/SV/0DuwnJ1EXFyy3fkqO5YHRDylxdcWgzH0xOG8iTA9ZcDQua56kMcEuMgsekHlEqMpxqZFiVpoNo4NpMtt73G96HkFzMRfyVDOBWQPTsIS20BhyQcgIHOShphOBRIdpx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466842; c=relaxed/simple;
	bh=XeM5byNfDLFL9tAqAidxi3XPnNmpaOXG/kBp3I75TDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nyr4xZdOGg7WhI5f/eKwS6BeN/t+NO6yY+s/mheCYgN9t57hYJUiUkxh8bGgs9VnMxatcUq6lFHV9DlK62kGDUgA/V9pXuNSpNoHMnxqmEnBGraBPY1VQUEZNHQWa2TOyet2Glhi46uuRaFm/hD8UyyWv1stg3E4lKFg1yImK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E0Dz5Avd; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E0Dz5Avd"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5c2c0e261aeso892408e0c.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 09:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466838; x=1787071638;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5hVUqKAq7+CGR3gV29vn5IOnGPr6UMObs1caCTW5v8Q=;
        b=jtjeIp4gfmKq3o8NmN8hjaOimYxnofK8LM9ZjDQHQpQIzu3RbcoN+H4pD8kJHG1QHR
         t3h6qAl05LndOdmelKjo2XtQZTDsG+szBzSlYHrf72kSIef5YCKhxu1969Cd3F2NN9x+
         9zI/7gfnBvKZo8epE8JCtAoVkfcWS0maB2WXtScztN9np4gApPrYnVUECglAEHZM5jCb
         HMbSkrwQckLTSLupQWw6qb7pZv0kODXEQh+cMXtIZ2q6bC+/qGlxhMTAcfQyv0mqIXaj
         lwdKWFh2BbFkDCf9a8lapZGJ4Oc0P1JU0O1guBdI4+YGowORmskIO/9RBeZjHOBV1kwF
         onlA==
X-Forwarded-Encrypted: i=1; AHgh+RqBdXs2qG69VxLqw36ARrQFsPO99zwwLLdXsHqTKySMbzksCJscY/HxduqV93nRj5+23Mq8dSH24x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8/AXaUXAHC6uC/TAb7uVPKoPjHy2Qvz2iCvmaYqs+8ImIaKd
	/DgHUg3ewtrKZYtlY1k2EUBAMW+aXLfES/IcPo6DEl8tNe/ApgU9jX8VZWJVc+X82/gX2qDlr0d
	QX+UMpmwXyYAkOc1+7a5F0ydlqXS+bhCI6wW950T5cmfb54xryk7xFBycXIQaBv6jPIavFBTKxz
	igOoS6M8Kr5rs2SZs/XEwH5LCaZp++BCxdtKfFeg5nW4/O4MT0EdkG5tvs1sOxOZzpQb0Qt79BZ
	Fh7eNX5wQ1CAUdhzzY7
X-Gm-Gg: AR+sD105W5sPOHb/gDeFfsfDS6bC5UM64LlJMOYyQsZEXM0e3ffsAjrxCXj/mol52lW
	8RIRypDKppgeGZAkXV7S1AiZ/kUH35JbK8NuU4pHzx0EUx8etd06cjTfpzzXn1QLObwgwisISKb
	PUUzlmpicedl977wH3YpI74dOykSh+tcYv5fjJCsnj+beVQoHuElArVsXG/qGkBnZN8b0sxIfXF
	pdRzh3MXMwGvIzYRwzWkmTqjzSTG0eXOZLBG/N4D00ZP0T+SwB/xugyRcBzXvdqQB9wY46Zd+l2
	/U4QreMcSJxpAG+ZvX6GMtVVQNUNbHYFydDXYzynqdbc4vkbHx5H5Zb0TPCXuXtrTwpAA60hNry
	Yt9vvjTuQEycq+FlJOSWjwCFJIInewu9LAsZqQBHsr41IINveeGv0LMR8G/BX3uzNfm4Wag5Src
	m8kIxMJnY1sgGvWOZGFy9403lReoZIpv6pmIp3i5wv
X-Received: by 2002:a05:6122:4591:b0:5bf:b879:15c0 with SMTP id 71dfb90a1353d-5c45039b18emr498866e0c.5.1786466837902;
        Tue, 11 Aug 2026 09:47:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c45b3d9972sm58111e0c.2.2026.08.11.09.47.17
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2026 09:47:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso4869354a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786466837; x=1787071637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5hVUqKAq7+CGR3gV29vn5IOnGPr6UMObs1caCTW5v8Q=;
        b=E0Dz5AvdZu3svnmUAmHJ3BC6ZdKw1ny2alwkMhUT05//xI2LyrqS2cOZi3uApYDD3u
         a6AN9ag93Kk+Gi/0o6+0oIgKxbjufi6+YCUDU4HWxfA4PDcao3AAVSVzeKxbCTqZqupH
         RpCUDtkYz6hPoXC4I+/x3A2fyfexjskWtIwGE=
X-Forwarded-Encrypted: i=1; AHgh+RqrWOCKVIamA6NIsjPS4KZn+DLuTNWfyH2y/Z7HDWEFOW18wlbqZPM9LSI6mZjcXZqHjMhClJrffwI=@vger.kernel.org
X-Received: by 2002:a05:6a20:2d13:b0:3c4:1916:9d46 with SMTP id adf61e73a8af0-3cc2bac42a9mr6230597637.27.1786466836465;
        Tue, 11 Aug 2026 09:47:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d13:b0:3c4:1916:9d46 with SMTP id adf61e73a8af0-3cc2bac42a9mr6230508637.27.1786466835825;
        Tue, 11 Aug 2026 09:47:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d7a366sm1085740eec.27.2026.08.11.09.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 09:47:15 -0700 (PDT)
Message-ID: <b6cdd25a-af18-40f4-8fc1-fac2e1d0ef41@broadcom.com>
Date: Tue, 11 Aug 2026 09:47:13 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] mmc: Add pstore backend for crash dump storage on
 eMMC
To: Kamal Dasu <kamal.dasu@broadcom.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>, Arend van Spriel <arend.vanspriel@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
 <CAKekbesT-CazRUv-LMU92h8pPP06PdrP8PQSTQZkeJs8vUePXw@mail.gmail.com>
 <CAKekbes22Es97vR39y==Ds-VszAOo0ypwYhVT2ODbSpkb=cZfA@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <CAKekbes22Es97vR39y==Ds-VszAOo0ypwYhVT2ODbSpkb=cZfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi Ulf,

On 6/10/26 10:01, Kamal Dasu wrote:
> 
> 
> On Wed, Jun 10, 2026 at 12:53 PM Kamal Dasu <kamal.dasu@broadcom.com 
> <mailto:kamal.dasu@broadcom.com>> wrote:
> 
> 
> 
>     On Wed, Apr 22, 2026 at 4:51 PM Kamal Dasu <kamal.dasu@broadcom.com
>     <mailto:kamal.dasu@broadcom.com>> wrote:
> 
>         This series adds mmcpstore, a pstore backend driver that enables
>         persistent storage of kernel crash logs on eMMC devices. When the
>         kernel panics, pstore captures the kmsg dump and writes it directly
>         to a dedicated MMC partition using polled I/O with interrupts
>         disabled.
> 
>         Changes since v4 (addresses Ulf Hansson's feedback on the v4 panic
>         host path, linux-mmc):
>         - mmc_panic_claim_host(): log claimed, runtime suspend, and
>            ongoing_mrq before claim; always call panic_prepare() when
>            implemented so the host can drain or gracefully terminate
>            in-flight requests, then force-claim. Vendor controllers may
>            supply their own panic_prepare for platform-specific cases (1/4).
>         - SDHCI: reference panic_prepare implementation; longer drain/reset
>            timeouts; document panic helper return values in kernel-doc
>         (2/4).
>         - mmcpstore: single prepare/claim path; panic_complete() after
>            panic_poll_completion() on panic writes (4/4).
> 
>         Changes since v3:
>         - Fixed kernel-doc warnings reported by kernel test robot:
>            - Added missing @param descriptions for sdhci_panic_prepare(),
>              sdhci_panic_poll_completion(), sdhci_panic_complete() (patch 2)
>            - Added missing @sect_offset param doc for
>              mmcpstore_do_request_internal() (patch 4)
>            - Fixed kernel-doc function name mismatch: mmcpstore_read() ->
>              mmcpstore_read_zone() (patch 4)
>            - Added missing @disk param doc for mmcpstore_card_add()
>         (patch 4)
>         - Removed unused 'offset_bytes' variable in
>            mmcpstore_register_for_card() (patch 4)
> 
>         Changes since v2 (RFC):
>         - Rebased onto v7.0-rc — no longer reverts any existing MMC core
>            or SDHCI changes (v1/v2 accidentally reverted recent upstream
>            commits due to being based on an older tree)
>         - Removed all erase/bitmap tracking logic — MMC/eMMC is managed
>            flash and does not need erase-before-write; the pstore_zone
>            framework handles zone management internally
>         - Uses standard MMC core request path (mmc_start_request) instead
>            of hand-building mmc_request structs; panic-context I/O is
>            handled through proper mmc_host_ops callbacks rather than ad-hoc
>            code in the driver
>         - Added panic-context ops to mmc_host_ops and sdhci_ops for clean
>            separation of panic and normal I/O paths
>         - Fixed deadlocks caused by spinlock contention during panic
>            (lockless mmc_panic_claim_host using WRITE_ONCE)
>         - Fixed data corruption in pstore recovery (zlib_inflate failures)
>            by letting the normal sdhci_request() path run instead of a
>            custom panic request handler
>         - Added PM suspend/resume support with eMMC re-initialization
>         - Supports module loading or builtin loading of the driver
>         - Added MAINTAINERS entry
>         - Split into 4-patch series for reviewability
> 
>         The series is structured as follows:
> 
>         Patch 1 adds panic-context operations to struct mmc_host_ops and a
>         lockless mmc_panic_claim_host() for use during kernel panic when
>         other CPUs are stopped and may hold locks. Host drivers may replace
>         panic_prepare with vendor-specific code where needed.
> 
>         Patch 2 implements the SDHCI reference panic_prepare (graceful
>         termination of in-flight work, then polled completion paths); other
>         MMC host drivers use the same mmc_host_ops hooks with their own
>         panic_prepare where the hardware differs.
> 
>         Patch 3 adds mmc_blk_get_card_by_name() helper to look up an
>         mmc_card from a block device name, used by the mmcpstore module
>         path for card discovery.
> 
>         Patch 4 adds the mmcpstore driver itself, which registers with the
>         pstore_blk framework and handles panic writes, PM suspend/resume,
>         and dual-path registration (direct probe hook for builtin,
>         mmc_blk_get_card_by_name() for module). Also adds probe/remove
>         hooks in block.c and declarations in block.h for the builtin path.
> 
>         Tested on Broadcom STB platforms (ARM64) with SDHCI controllers,
>         verified panic dump recovery across multiple panic/reboot cycles
>         with kmsg, pmsg, and console pstore; also tested with concurrent
>         I/O stress before panic.
> 
>         Previous submissions and related work:
>            RFC v1: https://lore.kernel.org/linux-
>         mmc/20221216212738.7928-1-kdasu.kdev@gmail.com/ <https://
>         lore.kernel.org/linux-mmc/20221216212738.7928-1-
>         kdasu.kdev@gmail.com/>
>            RFC v2: https://lore.kernel.org/linux-
>         mmc/20221222185948.12717-1-kdasu.kdev@gmail.com/ <https://
>         lore.kernel.org/linux-mmc/20221222185948.12717-1-
>         kdasu.kdev@gmail.com/>
>            v3: https://lore.kernel.org/linux-
>         mmc/20260319185705.1516950-1-kamal.dasu@broadcom.com/ <https://
>         lore.kernel.org/linux-mmc/20260319185705.1516950-1-
>         kamal.dasu@broadcom.com/>
>            v4: linux-mmc (same thread as v3; superseded by this v5)
>            Marvell MMC pstore attempt (2020):
>         https://lore.kernel.org/linux-mmc/20201207115753.21728-1-
>         bbudiredla@marvell.com/ <https://lore.kernel.org/linux-
>         mmc/20201207115753.21728-1-bbudiredla@marvell.com/>
>            pstore/blk documentation:
>         https://www.kernel.org/doc/html/latest/admin-guide/pstore-
>         blk.html <https://www.kernel.org/doc/html/latest/admin-guide/
>         pstore-blk.html>
> 
>         Kamal Dasu (4):
>            mmc: core: Add panic-context host operations for pstore backends
>            mmc: sdhci: Implement panic-context write support
>            mmc: block: Add helper to look up mmc_card by device name
>            mmc: core: Add MMC pstore backend driver
> 
>           MAINTAINERS                  |    6 +
>           drivers/mmc/core/Kconfig     |   12 +
>           drivers/mmc/core/Makefile    |    1 +
>           drivers/mmc/core/block.c     |   56 ++
>           drivers/mmc/core/block.h     |   18 +
>           drivers/mmc/core/core.c      |   54 ++
>           drivers/mmc/core/mmcpstore.c | 1511 ++++++++++++++++++++++++++
>         ++++++++
>           drivers/mmc/host/sdhci.c     |  173 +++-
>           drivers/mmc/host/sdhci.h     |    6 +
>           include/linux/mmc/host.h     |   12 +
>           10 files changed, 1845 insertions(+), 4 deletions(-)
>           create mode 100644 drivers/mmc/core/mmcpstore.c
> 
>         -- 
>         2.34.1
> 
> 
> 
> 
> Ulf,
> 
> I'm resending a gentle reminder regarding the v5 patch series for mmcpstore.
> 
> This version addresses your previous feedback on the v4 panic host path 
> and includes several key stability improvements:
> 
> - Implements a lockless mmc_panic_claim_host using WRITE_ONCE to avoid 
> deadlocks during panic.
> - Adds panic_prepare to the host ops to ensure in-flight requests are 
> drained and runtime PM states are handled before panic writes.
> - Uses standard MMC core request paths with polling-based completion for 
> robust I/O during a crash.
> - Includes full PM suspend/resume support with eMMC re-initialization.
> 
> The series has been tested thoroughly on Broadcom STB platforms (ARM64), 
> verifying reliable recovery of kmsg, pmsg, and console logs across 
> multiple panic cycles.
> 
> Please let me know if you need any further information or if there are 
> additional changes required for acceptance.

Is there anything we could do here to move this forward? We have large 
number of devices in the field that make use of that feature and we 
would really like for this to be included upstream and usable by others 
as well.

Thanks!
-- 
Florian
