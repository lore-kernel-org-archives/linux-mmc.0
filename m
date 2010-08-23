From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: MMC workflow (was Re: [PATCH] mmc: MMC 4.4 DDR support)
Date: Mon, 23 Aug 2010 15:05:21 -0700
Message-ID: <20100823150521.e6629a85.akpm@linux-foundation.org>
References: <1278658780-26397-1-git-send-email-hanumath.prasad@stericsson.com>
	<AANLkTikBdBhJeQ-t2+0echJfAxz529QZEYPJtyHUsROd@mail.gmail.com>
	<m3pqxbsibq.fsf@pullcord.laptop.org>
	<20100823204829.GB6510@console-pimps.org>
	<m34oelq9zb.fsf_-_@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47703 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754308Ab0HWWFz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Aug 2010 18:05:55 -0400
In-Reply-To: <m34oelq9zb.fsf_-_@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Matt Fleming <matt@console-pimps.org>, Linus Walleij <linus.ml.walleij@gmail.com>, linux-mmc@vger.kernel.org

On Mon, 23 Aug 2010 17:45:28 -0400
Chris Ball <cjb@laptop.org> wrote:

> Hi,
> 
>    > It's possible Andrew has a reason that hasn't been picked up yet.
>    > 
>    > Maybe what we really need is to get patchwork setup for the
>    > linux-mmc list? Other subsystem maintainers swear by it. That
>    > way, it'd be much harder for patches to go unnoticed.
> 
> Sounds good -- if no-one objects, I'll send e-mail to ftpadmin@k.o
> tomorrow asking for linux-mmc@ to be added to patchwork.k.o.
> 
> Andrew, how do you feel about MMC at the moment?  It seems like we
> could mostly use more people reviewing patches, but do you think it'd
> also help to have submitted patches go into a -next tree for testing?
> Would you like to have someone else track down which patches got held
> up along the way and should be revisited, or is that something you're
> already doing?
> 

I'm basically acting as a stopgap patch monkey until a real maintainer
comes along.

I'll happily read the patches myself but do very much like to see that
someone with mmc-specific experience has taken a look at them as well.

So for me, review really really helps.  The only other issue I have is
that I don't read the list often enough, so please do add me to cc on
replies if I was missed out on.

I actually "maintain" well over 100 "subsystems" in this manner[*]. 
Really I should be in MAINTAINERS for a lot of these so I get cc'ed
more reliably on those oddball once-off fixes.  But usually they're cc'ed
to lkml so I do see them.


[*]:

	grep '^# ' series

is below.  I have headings for "other maintainers trees" and headings
for "trees I maintain" and headings for random junk which probably
shouldn't be there any more.  That series file has been checked in 19194
times since Dec 2002.  I should get out more.


# 2.6.36
# me:
# 2.6.33, early
# acpi
# platform drivers
# x86
# alsa
# kgdb
# kmemcheck
# agp
# arm
# audit
# avr32
# btrfs
# ceph
# cifs
# cpufreq
# dm
# dmar (dwmw2)
# dma (Dan)
# dma-debug (Joerg Roedel <joerg.roedel@amd.com>)
# jfs
# pcmcia
# powerpc
# driver core
# dnotify
# drm
# dvb
# ecryptfs
# fscache
# fsnotify
# hpet
# i2c
# iommu
# irqs
# gfs
# hid
# hwpoison
# time
# ntp
# ia64
# ieee1394
# infiniband
# input
# kbuild
# kvm
# kvm/ia64
# lblnet
# leds
# libata
# pata
# ide
# m32r
# mfd
# microblaze
# async-tx
# mips
# mqueue
# mtd
# nfsd
# ntfs
# score
# spi
# squashfs
# ubi
# ubifs
# udf
# uwb
# connector (davem)
# atm
# wan
# irda
# i4l
# net
# netdev
# netfilter
# backlight
# battery
# blackfin
# bluetooth
# debugobjects
# ext4
# nfs
# ocfs2
# parisc
# security
# serial
# udf
# pci
# md
# perf
# regulator
# s390
# sched
# tejun stuff
# genirq
# lockdep
# fastboot
# rcu
# ftrace
# sh
# scsi
# block
# sparc
# staging
# uio
# usb
# v9fs
# vfs
# watchdog
# wireless
# xfs
# crypto
# xtensa
# rusty
# slab
# tty
# mm
# mmend
# security
# frv
# pagemap
# gigaset
# nommu
# sh
# h8/300
# alpha
# CPU hotplug
# power management
# m32r
# m68k
# mn10300
# cpuidle
# cris
# floppy
# uml
# v850
# Misc
# miscend
# drivers/misc
# *bmp085*: fold
# core kernel
# miscdev
# printk
# get_maintainer
# MAINTAINERS
# lib
# bkl removal
# sgi-xpc
# compat
# firmware
# mmc
# sdhci-*: perf regression (Albert Herranz <albert_herranz@yahoo.es>)
# checkpatch
# crc
# poll select
# epoll
# hwmon
# smm665: fold
# oss
# binfmt
# warn
# list
# topology:
# swiotlb
# kallsyms
# ramfs
# rwsem
# initramfs
# ncpfs
# dmi
# oprofile
# vt
# kprobes
# i2o
# xen
# autofs
# smbfs
# rtc
# gpio
# fbdev
# auxdisplay
# devmem
# pnp
# pnpbios
# pipe
# telephony
# minix
# ext2
# ext3
# befs
# isofs
# codafs
# nilfs
# hfs
# hfsplus
# ufs
# reiserfs
# hpfs
# hppfs
# fat
# quota
# documentation
# cgroups
# devcgroup
# memcgroup
# devscgroup
# cpusets
# ptrace
# utrace
# signals
# pgrp
# kmod
# coredump
# exit
# proc
# fork
# exec
# wait
# workqueues
# kthread
# cpu hotplug
# kdump
# idr
# ipc
# ipmi
# pty
# elf
# flat
# char
# hw_random
# drivers/misc
# partitions
# rapidio
# rbu
# keys
# sysctl
# pid management
# pidns
# userns
# edd
# nbd
# ioctl
# atmel
# aoe
# markers
# namespaces
# accounting
# taskstats
# random
# fuse
# futex
# edac
# gcov
# loop
# dma-mapping
# propagate these:
# adfs
# afs
# affs
# bfs
# panic
# parport
# pps
# memstick
# w1
# c2
# ramdisk
# kexec
# mmtimer
# ramzswap
# sysvfs
# cachefiles fs-cache
# markup_oops
# relayfs:
# aio
# dio
# omfs
# uv
# gru
# kfifo
# radix-tree
# resource
# ssb
# genclk
# cpualloc
# devpts
# byteorder
# unaligned
# cramfs
# ramoops
# ramzswap
# romfs
# freeze feature
# async
# vlynq
# qnx4
# static
# decompress
# ibft
# inflate deflate
# slow-work
# lkdtm
# lzo
# end
# debug stuff

